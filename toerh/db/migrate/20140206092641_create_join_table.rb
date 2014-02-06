class CreateJoinTable < ActiveRecord::Migration
  def change
      create_table :resources_tags, :id => false do |t|
      t.integer :resource_id
      t.integer :tag_id
    end
  end
end
