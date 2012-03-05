class AddFollowingCountToTwitterMember < ActiveRecord::Migration
  def change
    add_column :twitter_members, :following_count, :int
  end
end
