class AddColumnsToResource < ActiveRecord::Migration
  def change
    add_column :resources, :name, :string
    add_column :resources, :description, :string
    add_column :resources, :url, :string
  end
end
