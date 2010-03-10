class CreateStatusChanges < ActiveRecord::Migration
  def self.up
    create_table :status_changes do |t|
      t.integer :device_id
      t.date :time
      t.string :status
      t.text :reason

      t.timestamps
    end
  end

  def self.down
    drop_table :status_changes
  end
end
