class ChangeColumnInResourceTypeAgain < ActiveRecord::Migration
  def change
    rename_column :resource_types, :resource_type_name, :type_name
  end
end
