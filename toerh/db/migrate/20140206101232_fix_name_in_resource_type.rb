class FixNameInResourceType < ActiveRecord::Migration
  def change
    rename_column :resource_types, :type, :resource_type
  end
end
