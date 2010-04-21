class CreateFirewalls < ActiveRecord::Migration

  # 防火墙	firewall
  #
  #端口数量	port_qty
  #用户数	user_qty
  #是否支持VPN	vpn
  #安全过滤	security_filtering  
  #吞吐量	throughput
  #并发连接数	max_client
  def self.up
    create_table :firewalls do |t|
      t.integer "port_qty"
      t.integer "user_qty"
      t.string  "vpn"
      t.integer  "security_filtering"
      t.integer  "throughput"
      t.integer  "max_client"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :firewalls
  end
end
