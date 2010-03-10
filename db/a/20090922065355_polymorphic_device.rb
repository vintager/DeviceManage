class PolymorphicDevice < ActiveRecord::Migration
  def self.up
    add_column :devices, :detail_id, :integer
    add_column :devices, :detail_type, :string
  end

  def self.down
    remove_column :devices, :detail_id
    remove_column :devices, :detail_type
  end
end
