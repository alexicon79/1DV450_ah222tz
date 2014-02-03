class AddResourceRefToTags < ActiveRecord::Migration
  def change
    add_column :tags, :resource_id, :integer
    add_index :tags, :resource_id
  end
end
