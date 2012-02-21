class AddMeetupIdToMeetupTopics < ActiveRecord::Migration
  def change
    add_column :meetup_topics, :meetup_id, :integer
  end
end
