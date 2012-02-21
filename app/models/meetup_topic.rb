class MeetupTopic < ActiveRecord::Base
end

# == Schema Information
#
# Table name: meetup_topics
#
#  id         :integer(4)      not null, primary key
#  urlkey     :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  meetup_id  :integer(4)
#

