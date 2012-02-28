class CreateUserAffinities < ActiveRecord::Migration
  def change
    create_table :user_affinities do |t|
      t.integer :user_id
      t.integer :target_user_id
      t.integer :t_meetup_member_id
      t.string :meetup_topics_in_common
      t.integer :affinity_score

      t.timestamps
    end
  end
end
