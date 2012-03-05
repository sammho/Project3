class CreateTwitterMembers < ActiveRecord::Migration
  def change
    create_table :twitter_members do |t|
      t.integer :user_id
      t.string :screenname
      t.integer :twitter_id
      t.text :followers
      t.text :following
      t.text :categories
      t.string :profile_image_url
      t.string :location
      t.string :name
      t.string :description
      t.boolean :verified

      t.timestamps
    end
  end
end
