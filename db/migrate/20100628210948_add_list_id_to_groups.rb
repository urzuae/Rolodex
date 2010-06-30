class AddListIdToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :list_id, :integer
  end

  def self.down
    remove_column :groups, :list_id
  end
end
