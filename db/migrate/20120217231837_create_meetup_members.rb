class CreateMeetupMembers < ActiveRecord::Migration
  def change
    create_table :meetup_members do |t|
      t.string :name
      t.integer :user_id
      t.text :unparsed_json
      t.string :image_url
      t.string :linkedin_url
      t.string :twitter
      t.integer :meetup_id

      t.timestamps
    end
  end
end
