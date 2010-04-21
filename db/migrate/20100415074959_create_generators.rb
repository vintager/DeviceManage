class CreateGenerators < ActiveRecord::Migration
  #  发电机	generator
  #
  #输出电压	voltage
  #输出功率	power  
  #燃油种类	fuel_type  
  #工作时间	discharge_time
  #邮箱容积	oil_capacity
  #启动方式	starting_method 
  #备注    memo 


  def self.up
    create_table :generators do |t|
      t.integer "voltage"
      t.integer "power"
      t.string "fuel_type"
      t.integer  "discharge_time"
      t.integer  "oil_capacity"
      t.string  "starting_method"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :generators
  end
end
