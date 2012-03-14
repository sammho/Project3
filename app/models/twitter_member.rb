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
    new_twitter_member = TwitterMember.new

    new_twitter_member.screenname = twitter_user.screen_name
    new_twitter_member.twitter_id = twitter_user.id
    new_twitter_member.profile_image_url = twitter_user.profile_image_url
    new_twitter_member.location = twitter_user.location
    new_twitter_member.name = twitter_user.name
    new_twitter_member.description = twitter_user.description
    new_twitter_member.verified = twitter_user.verified

    if twitter_user.protected == true
      new_twitter_member.save
    else
      twitter_user_followers_c = Twitter.follower_ids(twitter_user.screen_name)
      twitter_followers = twitter_user_followers_c.collection
      cursor = twitter_user_followers_c.next
      
      loop_limit = 0
      while cursor != 0
        more_followers = Twitter.follower_ids(twitter_user.screen_name, :cursor => cursor)
        twitter_followers.concat(more_followers.collection)
        cursor = more_followers.next

        # to protect Twitter API limit, will restrict to 25K followers
        loop_limit += 1
        if loop_limit > 5  then
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

        # to protect Twitter API limit, will restrict to 25K followers
        loop_limit += 1
        if loop_limit > 5 then
          break 
        end
      end

      puts "Almost there #{twitter_user.screen_name}\n"

      new_twitter_member.followers = twitter_followers
      new_twitter_member.following = twitter_following
      new_twitter_member.followers_count = twitter_user.followers_count
      new_twitter_member.following_count = twitter_user.friends_count

      if new_twitter_member.save
        return new_twitter_member
      else
        puts new_twitter_member.errors.full_messages

      end
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

