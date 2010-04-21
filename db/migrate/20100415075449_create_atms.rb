class CreateAtms < ActiveRecord::Migration
  #  自动柜员机	atm
  #
  #是否穿墙	through_the_wall
  #是否带存款模块	deposit_module 
  #操作系统类型	system
  #钞箱数量 cash_box_qty
  #是否为触摸屏 touch_screen
  #是否有监控	monitor

  def self.up
    create_table :atms do |t|
      t.string "through_the_wall"
      t.string "deposit_module"
      t.string "cash_box_qty"
      t.string "touch_screen"
      t.string  "system"
      t.string  "monitor"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :atms
  end
end
