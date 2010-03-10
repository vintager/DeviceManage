class RenameType < ActiveRecord::Migration
  def self.up
    rename_column :devices, :type, :device_type
  end
  def self.down
    rename_column :orders, :device_type, :type
  end

end
