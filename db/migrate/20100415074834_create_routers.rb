class CreateRouters < ActiveRecord::Migration
   #  路由器	router
    #
    #是否模块化	modularization
    #插槽数量	slot_qty
    #内存	mem
    #背板带宽	total_backplane_bandwidth  
    #广域网口数量	wan_port_qty
    #局域网口数量	lan_port_qty
    #电源模块数量	power_module_qty 
    #支持vpn	vpn
    #支持qos	qos
  def self.up
    create_table :routers do |t|
      t.integer "mem"
      t.integer "total_backplane_bandwidth"
      t.string  "modularization"
      t.integer  "wan_port_qty"
      t.integer  "lan_port_qty"
      t.integer "power_module_qty"
      t.integer "slot_qty"
      t.string "vpn"
      t.string  "qos"
      t.text     "memo"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :routers
  end
end
