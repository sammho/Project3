class CreateMeetupTopics < ActiveRecord::Migration
  def change
    create_table :meetup_topics do |t|
      t.integer :id
      t.string :urlkey
      t.string :name

      t.timestamps
    end
  end
end
