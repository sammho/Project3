class TwitterMember < ActiveRecord::Base
  serialize :followers 
  serialize :following
  serialize :categories
  validates(:twitter_id, :presence => true)

  def self.find_or_create_from_twitter_id(t_id)
    if found_user = TwitterMember.find_by_twitter_id(t_id)
      return found_user
    else
      # TODO: this method may be somewhat deprecated, better to specify the user_id field directly
      # since this could get confused with users who are just a string of numbers.
      # We're assuming here the API logic is to look for a string vs an integer
      twitter_user = Twitter.user(t_id) 
      return TwitterMember.create_from_twitter_object(twitter_user)

    end

  end

  ## This creation method is primarily used from a Meetup lookup
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

    twitter_user = Twitter.user(screenname)
    TwitterMember.create_from_twitter_object(twitter_user)
  end

  def self.create_from_twitter_object(twitter_user)
    if twitter_user.protected == true
      return TwitterMember.create!(:screenname => twitter_user.screen_name,
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
      twitter_user_followers_c = Twitter.follower_ids(twitter_user.screen_name)
      twitter_followers = twitter_user_followers_c.collection
      cursor = twitter_user_followers_c.next
      
      loop_limit = 0
      while cursor != 0
        more_followers = Twitter.follower_ids(twitter_user.screen_name, :cursor => cursor)
        twitter_followers.concat(more_followers.collection)
        cursor = more_followers.next

        # to protect Twitter API limit, will restrict to 50K followers
        loop_limit += 1
        if loop_limit > 10 then
          break 
        end
      end

      twitter_user_following_c = Twitter.friend_ids(twitter_user.screen_name)
      twitter_following = twitter_user_following_c.collection
      cursor = twitter_user_following_c.next
      
      loop_limit = 0
      while cursor != 0
        more_following = Twitter.friend_ids(twitter_user.screen_name, :cursor => cursor)
        twitter_following.concat(more_following.collection)
        cursor = more_following.next

        # to protect Twitter API limit, will restrict to 50K followers
        loop_limit += 1
        if loop_limit > 10 then
          break 
        end
      end

      return TwitterMember.create!(:screenname => twitter_user.screen_name,
                                   :twitter_id => twitter_user.id,
                                   #:followers => Twitter.follower_ids(screenname),
                                   #:following => Twitter.friend_ids(screenname),
                                   :followers => twitter_followers,
                                   :following => twitter_following,
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
  def twitter_followers_in_common(user_b, options={})
    return (user_b.followers & self.followers)
  end

  def twitter_following_in_common(user_b, options={})
    return (user_b.following & self.following)
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

