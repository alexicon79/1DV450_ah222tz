class RemoveTagFromResources < ActiveRecord::Migration
 def up
    remove_column :resources, :tag_id
  end

  def down
    add_column :resources, :tag_id, :integer
    add_index :resources, :tag_id
  end
end
