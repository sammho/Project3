class AddLinkedInToUserAffinities < ActiveRecord::Migration
  def change
    add_column :user_affinities, :linked_in, :boolean
    add_column :user_affinities, :twitter, :boolean
  end
end
