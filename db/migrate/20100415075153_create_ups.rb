class CreateUps < ActiveRecord::Migration
  #  ups
  #
  #额定容量	rated capacity
  #输出电压	output voltage
  #输入电压	input voltage
  #输入电压范围	voltage range
  #标称后备时间	backup time
  #转换时间	transition time
  #类型	ups_type
  #并机数量	link qty
  #
  #电池电压	battery voltage  
  #电池容量	battery capacity
  #电池型号	battery model
  #电池品牌	battery brand
  #每组电池数量	battery qty per group
  #电池组数	battery group
  #备注    memo 


  def self.up
    create_table :ups do |t|
      t.integer "rated_capacity"
      t.integer "output_voltage"
      t.integer "input_voltage"
      t.integer "voltage_range"
      t.integer "backup_time"
      t.integer "transition_time"
      t.string "ups_type"
      t.integer "link_qty"

      t.integer "battery_voltage"
      t.integer "battery_capacity"
      t.string  "battery_model"
      t.string  "battery_brand"
      t.integer  "battery_qty_per_group"
      t.integer  "battery_group"
      t.text     "memo"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :ups
  end
end
