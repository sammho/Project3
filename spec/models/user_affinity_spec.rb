require 'spec_helper'

describe UserAffinity do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: user_affinities
#
#  id                      :integer(4)      not null, primary key
#  user_id                 :integer(4)
#  target_user_id          :integer(4)
#  t_meetup_member_id      :integer(4)
#  meetup_topics_in_common :string(255)
#  affinity_score          :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#  linked_in               :boolean(1)
#  twitter                 :boolean(1)
#

