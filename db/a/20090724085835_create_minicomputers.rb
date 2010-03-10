class CreateMinicomputers < ActiveRecord::Migration
  def self.up
    create_table :minicomputers do |t|
      t.integer :device_id
      t.string :cpu
      t.integer :cpu_qty
      t.integer :disk
      t.integer :disk_qty
      t.string :nic
      t.string :nic
      t.integer :nic_qty
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :minicomputers
  end
end
