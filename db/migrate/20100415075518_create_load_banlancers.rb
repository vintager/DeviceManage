class CreateLoadBanlancers < ActiveRecord::Migration
  #  负载均衡器	load_balancer
    #
#内存	mem
#端口数量	port_qty
#cpu
#cpu 数量 cpu_qty
#电源模块数量 power_module_qty
#工作层数 layer
  def self.up
    create_table :load_banlancers do |t|
      t.integer "mem"
      t.integer "port_qty"
      t.string  "cpu"
      t.integer  "cpu_qty"
      t.integer "power_module_qty"
      t.string "layer"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :load_banlancers
  end
end
