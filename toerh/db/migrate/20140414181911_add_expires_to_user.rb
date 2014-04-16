class AddExpiresToUser < ActiveRecord::Migration
  def change
    add_column(:users, :client_expires, :string)
  end
end
