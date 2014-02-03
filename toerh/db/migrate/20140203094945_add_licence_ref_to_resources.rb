class AddLicenceRefToResources < ActiveRecord::Migration
  def change
    add_column :resources, :licence_id, :integer
    add_index :resources, :licence_id
  end
end
