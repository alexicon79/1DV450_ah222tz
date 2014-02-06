class CreateJoinTable < ActiveRecord::Migration
  def change
      create_table :resources_tags, :id => false do |t|
      t.integer :resource_id
      t.integer :tag_id
    end

      add_index :resources_tags, ["resource_id", "tag_id"]
  end
end
