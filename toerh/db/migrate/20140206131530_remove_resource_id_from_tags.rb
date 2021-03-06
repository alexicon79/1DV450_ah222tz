class RemoveResourceIdFromTags < ActiveRecord::Migration
  def up
    remove_column :tags, :resource_id
  end

  def down
    add_column :tags, :resource_id, :integer
    add_index :tags, :resource_id
  end
end
