class AddAddressAndPhoneToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :address, :string
    add_column :contacts, :phone, :string
  end

  def self.down
    remove_column :contacts, :phone
    remove_column :contacts, :address
  end
end
