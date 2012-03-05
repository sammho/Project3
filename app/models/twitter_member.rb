class TwitterMember < ActiveRecord::Base
  serialize :followers 
  serialize :following
  serialize :categories
  validates(:twitter_id, :presence => true)

  def self.create_from_screenname(screenname)
    puts Twitter.user(screenname).inspect
    twitter_user = Twitter.user(screenname)
    puts "Found user: #{screenname} with id #{twitter_user.id}\n"

    return TwitterMember.create!(:screenname => screenname,
                                 :twitter_id => twitter_user.id,
                                 :followers => Twitter.follower_ids(screenname),
                                 :following => Twitter.friend_ids(screenname),
                                 #:categories => Twitter.suggestions(screenname),
                                 :profile_image_url => twitter_user.profile_image_url,
                                 :location => twitter_user.location,
                                 :name => twitter_user.name,
                                 :description => twitter_user.description,
                                 :verified => twitter_user.verified)

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
#

