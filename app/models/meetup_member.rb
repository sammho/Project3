class MeetupMember < ActiveRecord::Base

  validates(:meetup_id, :presence => true)
  serialize :unparsed_json

  require 'iconv'
  
  def self.create_new_from_meetup(meetup_member_id)
    member = RMeetup::Client.fetch(:members, {:member_id => meetup_member_id}).first

    if member.other_services["linkedin"] && 
        member.other_services["linkedin"]["identifier"] =~ /.*linkedin.com.*/

      # for now, let's not extract the field, let's just use the link directly

      linked_in_url = member.other_services["linkedin"]["identifier"]
      #linkedin_re = /linkedin.com\/in\/(\w+)/
      #linked_in_url = linkedin_re.match(member.first.other_services["linkedin"]["identifier"])

      ## Technically this is just the name and not the URL
      #linked_in_url = $1
    else
      linked_in_url = nil 
    end

    if member.other_services["twitter"]
      twitter = member.other_services["twitter"]["identifier"]
      twitter_stripped = twitter[1..-1]

      # The problem with this reset flag is it requires Meetup member to be created again
      # TODO: Get rid of this twitter reset flag
      twitter_reset_flag = 0
      if twitter_reset_flag && (member_to_delete = TwitterMember.find_by_screenname(twitter_stripped))
        member_to_delete.destroy
        TwitterMember.create_from_screenname(twitter_stripped)
      elsif TwitterMember.find_by_screenname(twitter_stripped)  
      else
        TwitterMember.create_from_screenname(twitter_stripped)
      end
    else
      twitter = nil
    end

    # Need to clean up bad utf-8 characters that are causing errors
    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    clean_name = ic.iconv(member.name + ' ')[0..-2]

    # Need to clean up topics because of utf-8, let's just pull out the topic ids and store
    @topics = []
    member.topics.each do |topic|
      topic_id = topic["id"].to_i
      @topics << topic["id"]

      if MeetupTopic.find_by_meetup_id(topic["id"])
        # Topic exists! Yay!
      else
        MeetupTopic.create!(:meetup_id => topic["id"],
                            :urlkey => topic["urlkey"],
                            :name => topic["name"])
      end

    end

    if update_member = MeetupMember.find_by_meetup_id(meetup_member_id)

      return MeetupMember.update(update_member.id, {:name => clean_name, 
                                  #:meetup_id => member.member_id, 
                                  :meetup_id => meetup_member_id,
                                  #:unparsed_json => member.first.topics,
                                  :unparsed_json => @topics, 
                                  :image_url => member.photo_url,
                                  :linkedin_url => linked_in_url,
                                  :twitter =>   twitter} )

    else
      return MeetupMember.create!(:name => clean_name, 
                                  #:meetup_id => member.member_id, 
                                  :meetup_id => meetup_member_id,
                                  #:unparsed_json => member.first.topics,
                                  :unparsed_json => @topics, 
                                  :image_url => member.photo_url,
                                  :linkedin_url => linked_in_url,
                                  :twitter =>   twitter )
    end

  end

end

# == Schema Information
#
# Table name: meetup_members
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  user_id       :integer(4)
#  unparsed_json :text
#  image_url     :string(255)
#  linkedin_url  :string(255)
#  twitter       :string(255)
#  meetup_id     :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

