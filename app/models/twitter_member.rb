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
  def twitter_followers_in_common(user_b_screenname, options={})
    user_a_followers = self.followers.collection
    cursor = self.followers.next
    while cursor != 0
      more_followers = Twitter.follower_ids(self.screenname, :cursor => cursor)
      user_a_followers.concat(more_followers.collection)
      cursor = more_followers.next
      loop_limit += 1
      if loop_limit > 100 then
        break 
      end
    end

    user_b = TwitterMember.create_from_screenname(user_b_screenname)
    user_b_followers = user_b.followers.collection

    cursor = user_b.followers.next

    loop_limit = 0 # For testing, make sure you exit while loop after 10 iterations
    while cursor != 0
      more_followers = Twitter.follower_ids(user_b.screenname, :cursor => cursor)
      user_b_followers.concat(more_followers.collection)
      cursor = more_followers.next
      loop_limit += 1
      if loop_limit > 100 then
        break 
      end
    end

    return (user_b_followers & user_a_followers)

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

