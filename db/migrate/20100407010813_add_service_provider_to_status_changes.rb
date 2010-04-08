class AddServiceProviderToStatusChanges < ActiveRecord::Migration
  def self.up
    add_column :status_changes,:service_provider, :string
    add_column :status_changes,:department, :string
  end

  def self.down
    remove_column :status_changes,:service_provider
    remove_column :status_changes,:department
  end
end
