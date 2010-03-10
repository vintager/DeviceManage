class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :name
      t.string :addr
      t.string :contact
      t.string :phone
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end
