class ChangeColumnInResourceType < ActiveRecord::Migration
  def change
    rename_column :resource_types, :resource_type, :resource_type_name
  end
end
