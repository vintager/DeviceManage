class RemoveDeviceIdFromMinicomputer < ActiveRecord::Migration
  def self.up
    remove_column :minicomputers, :device_id
  end

  def self.down
    add_column :minicomputers, :device_id, :string
  end
end
