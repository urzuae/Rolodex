class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :company
      t.string :avatar

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
