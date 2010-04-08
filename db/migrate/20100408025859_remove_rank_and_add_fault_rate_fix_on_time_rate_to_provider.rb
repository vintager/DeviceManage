class RemoveRankAndAddFaultRateFixOnTimeRateToProvider < ActiveRecord::Migration
  def self.up
    remove_column :providers, :rank
    add_column :providers, :fault_rate, :string
    add_column :providers, :fix_on_time_rate, :string
  end

  def self.down
    add_column :providers, :rank, :integer
    remove_column :providers, :fault_rate
    remove_column :providers, :fix_on_time_rate
  end
end
