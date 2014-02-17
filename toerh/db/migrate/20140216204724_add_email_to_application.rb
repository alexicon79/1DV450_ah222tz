class AddEmailToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :contact_email, :string
  end
end
