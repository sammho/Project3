class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  def meetup_member_id
   return MeetupMember.find_by_user_id(self.id).meetup_id
  end

  def topics_in_common(found_member)
    @my_topics = MeetupMember.find(self.id).unparsed_json

    @common_topics = []

    found_member.unparsed_json.each do |topic|
      if @my_topics.include?(topic)
        @common_topics << topic
      else
      end

    end

    return @common_topics
  end

  def topics
    return MeetupMember.find(self.id).unparsed_json
  end

  def calculate_affinity(target_member)

    if affinity = UserAffinity.find_by_user_id_and_t_meetup_member_id(self.id, target_member.meetup_id)
      ## TODO: for now, let's always recalulate affinity scores (particularly to populate empties)
      ## TODO: Add additional condition to recalculate if update is > 1 month
    else
      affinity = UserAffinity.new
    end

    ## TODO: Do I really need to update all these same fields?
    @common_topics = self.topics_in_common(target_member)
    
    affinity.user_id = id
    affinity.t_meetup_member_id = target_member.meetup_id
    affinity.meetup_topics_in_common = @common_topics
    affinity.linked_in = !target_member.linkedin_url.nil? 
    affinity.twitter = !target_member.twitter.nil? 

    @common_topics.count
    total_user_topics = MeetupMember.find_by_user_id(id).unparsed_json.count 
    target_member.unparsed_json.count 

    ## Affinity score calculation
    ## .1 * Twitter + .2 * LinkedIn + .5 * % in common + .2 * (# in common - max 20)

    if @common_topics.count >= 20
      normalized_common_topics_count = 20
    else
      normalized_common_topics_count = @common_topics.count
    end

    twitter_score = (affinity.twitter ? 10.0 : 0.0) 
    linkedin_score = (affinity.linked_in ? 20.0 : 0.0) 
    topics_score = 50.0 * (@common_topics.count.to_f / (self.topics.count + 1.0))
    abs_topics_score = 20.0 * (normalized_common_topics_count.to_f / 20.0)

    #affinity.affinity_score = (affinity.twitter ? 10 : 0) +
    affinity.affinity_score = (affinity.twitter ? 10.0 : 0.0) +
                              (affinity.linked_in ? 20.0 : 0.0) +
                              50.0 * (@common_topics.count / (self.topics.count + 1.0)) +
                              20.0 * (normalized_common_topics_count / 20.0)

    #puts "\nCalculating score for #{target_member.name}\n"
    #puts "Scores are Twitter #{twitter_score} LI: #{linkedin_score} topics #{topics_score} abs #{abs_topics_score}\n"
    #puts "Twitter is #{(affinity.twitter ? 10 : 0)}\n" 
    #puts "Linked in is #{(affinity.linked_in ? 20 : 0)}\n"
    #puts "Common topics count is #{@common_topics.count}\n"
    #puts "Self topics count is #{self.topics.count}\n"
    #puts "% common is #{50.0 * (@common_topics.count / (self.topics.count + 1.0))}\n"
    #puts "Abs % is #{20.0 * (normalized_common_topics_count / 20.0)}\n"

    #puts "Affinity of #{target_member.name} is #{affinity.affinity_score}\n"

    affinity.save

  end

  def get_affinity(target_meetup_id)
    return UserAffinity.find_by_user_id_and_t_meetup_member_id(self.id, target_meetup_id)
  end

  def get_twitter_topics_in_common(target_screenname)
    # First need to make sure this user has a twitter profile to compare
    if self.meetup_member.twitter_member
      return 999

    else
      return 0
    end

  end

  # TODO: Would this somehow be automatically defined by defining the relationship?
  # Not sure if it's possible since neither of them are exclusive relationships
  # TODO: Create a test here for a user w/o a meetup account (or is this req'd?)
  def meetup_member
    return MeetupMember.find_by_user_id(self.id)
  end

  def twitter_member
    return TwitterMember.find_by_user_id(self.id)

  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#

