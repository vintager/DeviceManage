class AddChangeRecordIdToDevice < ActiveRecord::Migration
  def self.up
    add_column :devices, :state_change_id, :integer
  end

  def self.down
    remove_column :devices, :state_change_id
  end
end
