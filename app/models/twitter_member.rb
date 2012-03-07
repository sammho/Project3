class TwitterMember < ActiveRecord::Base
  serialize :followers 
  serialize :following
  serialize :categories
  validates(:twitter_id, :presence => true)

  def self.create_from_screenname(screenname)

    # To be safe, I should always clean up screennames here
    # remove leading @ sign and or pulling from email format

    if screenname =~ /^\w+$/
    elsif screenname =~ /^@(\w+)/
      screenname = $1
    elsif screenname =~ /(\w+)@\w+.com/
      screenname = $1

    else
      puts "Error: couldn't parse #{screenname} for twitter\n"
      return
    end

    puts Twitter.user(screenname).inspect
    twitter_user = Twitter.user(screenname)
    puts "Found user: #{screenname} with id #{twitter_user.id}\n"

  
    if twitter_user.protected == true
      return TwitterMember.create!(:screenname => screenname,
                                   :twitter_id => twitter_user.id,
                                   #:followers => Twitter.follower_ids(screenname), #unavailable if protected
                                   #:following => Twitter.friend_ids(screenname), #unavailable
                                   #:categories => Twitter.suggestions(screenname),
                                   :profile_image_url => twitter_user.profile_image_url,
                                   :location => twitter_user.location,
                                   :name => twitter_user.name,
                                   :description => twitter_user.description,
                                   :verified => twitter_user.verified)

    else
      return TwitterMember.create!(:screenname => screenname,
                                   :twitter_id => twitter_user.id,
                                   :followers => Twitter.follower_ids(screenname),
                                   :following => Twitter.friend_ids(screenname),
                                   :followers_count => twitter_user.followers_count,
                                   :following_count => twitter_user.friends_count,
                                   #:categories => Twitter.suggestions(screenname),
                                   :profile_image_url => twitter_user.profile_image_url,
                                   :location => twitter_user.location,
                                   :name => twitter_user.name,
                                   :description => twitter_user.description,
                                   :verified => twitter_user.verified)
    end


  end

  # Return the followers (array) that 2 users have in common
  # user_b must be the screenname
  def twitter_followers_in_common(user_b, options={})
    # create arrays for boths users of all their ids to parse cursor object
    # loop through twitter_userss followers, check if user_b.contains follower_id
    # Should we just do this at the beginning when we create a new member and store it as such?
    # Database implcation issues at scale?
    user_a_followers = self.followers.collection
    cursor = self.followers.next
    while cursor != 0
      # keep pulling the followers into an array
      # what about for the case when the user has less than 5000, let's initialize with the first page
      more_followers = Twitter.followers(self.screenname, :curser => cursor)
      @user_a_followers << more_followers.collection
      cursor = more_followers.next
    end

    return user_a_followers

  end
end

# == Schema Information
#
# Table name: twitter_members
#
#  id                :integer(4)      not null, primary key
#  user_id           :integer(4)
#  screenname        :string(255)
#  twitter_id        :integer(4)
#  followers         :text
#  following         :text
#  categories        :text
#  profile_image_url :string(255)
#  location          :string(255)
#  name              :string(255)
#  description       :string(255)
#  verified          :boolean(1)
#  created_at        :datetime
#  updated_at        :datetime
#  followers_count   :integer(4)
#  following_count   :integer(4)
#

