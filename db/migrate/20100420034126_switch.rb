#  交换机	switch
#
#交换机类型	switch_type
#内存	mem
#背板带宽	total_backplane_bandwidth  
#是否模块化	modularization
#端口类型	port_type
#端口速率	port_rate
#端口数量	port_qty
#是否三层	3_layer
#vlan支持	vlan
#电源模块数量	power_modules_qty 
#插槽数量	slot_qty
#是否可以堆叠	Stack 
#备注    memo
class Switch < ActiveRecord::Migration
  def self.up
    create_table "switches", :force => true do |t|
      t.string "switch_type"
      t.integer "mem"
      t.integer "total_backplane_bandwidth"
      t.string  "modularization"
      t.string  "port_type"
      t.integer  "port_rate"
      t.integer "port_qty"
      t.string "layer"
      t.string  "vlan"
      t.integer "power_module_qty"
      t.integer "slot_qty"
      t.string  "stack"
      t.text     "memo"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
