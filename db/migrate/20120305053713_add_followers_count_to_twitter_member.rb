class AddFollowersCountToTwitterMember < ActiveRecord::Migration
  def change
    add_column :twitter_members, :followers_count, :int
  end
end
