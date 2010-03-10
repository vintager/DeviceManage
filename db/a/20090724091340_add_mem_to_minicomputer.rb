class AddMemToMinicomputer < ActiveRecord::Migration
  def self.up
    add_column :minicomputers, :mem, :integer
  end

  def self.down
    remove_column :minicomputers, :mem
  end
end
