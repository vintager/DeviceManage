class CreateSwitches < ActiveRecord::Migration
  def self.up
    create_table :switches do |t|
      t.integer :device_id
      t.integer :port
      t.integer :layer
      t.integer :speed
      t.integer :back_speed
      t.text :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :switches
  end
end
