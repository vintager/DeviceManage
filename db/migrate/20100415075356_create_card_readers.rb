class CreateCardReaders < ActiveRecord::Migration
  #  读卡器	card_reader 
  #   
  #卡类型	card_type
  #读写	read_write
  #接口 interface

  def self.up
    create_table :card_readers do |t|
      t.string  "card_type"
      t.string  "read_write"
      t.string  "interface"

      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :card_readers
  end
end
