class AddNameToResourceType < ActiveRecord::Migration
  def change
    add_column :resource_types, :type, :string
  end
end
