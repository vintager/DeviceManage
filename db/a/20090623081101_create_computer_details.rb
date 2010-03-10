class CreateComputerDetails < ActiveRecord::Migration
  def self.up
    create_table :computer_details do |t|
      t.integer :device_id
      t.string :cpu
      t.string :mem
      t.string :display
      t.string :disk

      t.timestamps
    end
  end

  def self.down
    drop_table :computer_details
  end
end
