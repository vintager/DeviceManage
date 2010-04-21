class CreatePrinters < ActiveRecord::Migration
  #  打印机	printer
  #
  #打印方式	printer_method
  #打印机类型	printer_type
  #是否为彩色	color
  #接口	interface
  #是否有网络模块	net_module
  #支持双面打印	duplex_printing  

  def self.up
    create_table :printers do |t|
      t.string "printer_method"
      t.string "printer_type"
      t.string  "color"
      t.string  "interface"
      t.string "net_module"
      t.string "duplex_printing"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :printers
  end
end
