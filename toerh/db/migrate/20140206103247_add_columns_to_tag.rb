class AddColumnsToTag < ActiveRecord::Migration
  def change
    add_column :tags, :tag_name, :string
  end
end
