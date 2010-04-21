class CreateDiskArrays < ActiveRecord::Migration
  #  磁盘阵列	disk_array
    #
    #最大存储容量	max_capacity
    #插槽数量	slot_qty
    #数据接口	interface
    #传输速率	baud_rate
    #高速缓存	cache
    #平均故障间隔时间	mtbf

  def self.up
    create_table :disk_arrays do |t|
      t.integer "max_capacity"
      t.integer "slot_qty"
      t.string  "interface"
      t.integer  "mtbf"
      t.integer "baud_rate"
      t.integer "cache"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :disk_arrays
  end
end
