class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.integer :no
      t.string :brand
      t.string :sn
      t.string :type
      t.string :model
      t.string :admin
      t.string :department
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
