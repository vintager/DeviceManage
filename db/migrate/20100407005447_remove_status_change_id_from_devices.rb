class RemoveStatusChangeIdFromDevices < ActiveRecord::Migration
  def self.up
    remove_column :devices, :status_change_id
  end

  def self.down
    add_column :devices,:status_change_id, :integer
  end
end
