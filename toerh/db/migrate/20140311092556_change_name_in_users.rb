class ChangeNameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :firstname, :name
    remove_column :users, :lastname
  end
end
