class CreateAirConditions < ActiveRecord::Migration
  #  空调	air_condition
  #电压	voltage
  #功率	power
  #制冷量	cooling_capacity  
  #送风方式	air_supply_method  
  #加热方式	heating_method  
  #加湿方式	humidity_method
  #风量	air_output
  #噪音	noises


  def self.up
    create_table :air_conditions do |t|
      t.integer "voltage"
      t.integer "power"
      t.integer "cooling_capacity"
      t.string  "air_supply_method"
      t.string  "heating_method"
      t.string  "humidity_method"
      t.integer "air_output"
      t.integer "noises"
      t.text     "memo"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :air_conditions
  end
end
