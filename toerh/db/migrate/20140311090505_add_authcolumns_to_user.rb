class AddAuthcolumnsToUser < ActiveRecord::Migration
  def change
    add_column(:users, :provider, :string)
    add_column(:users, :uid, :string)
    add_column(:users, :token, :string)
    add_column(:users, :auth_token, :string)
    add_column(:users, :token_expires, :datetime)
  end
end
