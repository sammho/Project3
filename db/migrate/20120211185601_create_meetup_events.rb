class CreateMeetupEvents < ActiveRecord::Migration
  def change
    create_table :meetup_events do |t|

      t.timestamps
    end
  end
end
