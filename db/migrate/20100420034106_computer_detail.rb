#    计算机设备	computer
#
#cpu	cpu
#cpu数量	cpu_qty
#内存	mem
#硬盘	disk
#硬盘数量	disk_qty
#网卡	nic
#网卡数量	nic_qty
#显示器	display
class ComputerDetail < ActiveRecord::Migration
  def self.up
    create_table "computer_details", :force => true do |t|
      t.string   "cpu"
      t.integer  "cpu_qty"
      t.integer  "disk"
      t.integer  "disk_qty"
      t.string   "nic"
      t.integer  "nic_qty"
      t.integer  "mem"
      t.text     "display"

      t.text     "memo"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
