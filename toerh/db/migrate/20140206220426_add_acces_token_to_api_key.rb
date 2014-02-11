class AddAccesTokenToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :access_token, :string
  end
end
