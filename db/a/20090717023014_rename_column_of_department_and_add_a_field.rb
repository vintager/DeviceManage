class RenameColumnOfDepartmentAndAddAField < ActiveRecord::Migration
  def self.up
    rename_column :departments, :parent, :parent_id
    change_column :departments, :parent_id, :integer
    add_column :departments, :address, :string
  end

  def self.down
    change_column :departments, :parent_id, :string
    rename_column :departments, :parent_id, :parent
    remove_column :departments, :address, :string
  end
end
