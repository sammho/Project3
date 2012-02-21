require 'spec_helper'

describe MeetupMember do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: meetup_members
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  user_id       :integer(4)
#  unparsed_json :text
#  image_url     :string(255)
#  linkedin_url  :string(255)
#  twitter       :string(255)
#  meetup_id     :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

