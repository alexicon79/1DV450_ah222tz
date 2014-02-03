class AddTagRefToResources < ActiveRecord::Migration
  def change
    add_column :resources, :tag_id, :integer
    add_index :resources, :tag_id
  end
end
