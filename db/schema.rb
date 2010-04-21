# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100420034126) do

  create_table "air_conditions", :force => true do |t|
    t.integer  "voltage"
    t.integer  "power"
    t.integer  "cooling_capacity"
    t.string   "air_supply_method"
    t.string   "heating_method"
    t.string   "humidity_method"
    t.integer  "air_output"
    t.integer  "noises"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "atms", :force => true do |t|
    t.string   "through_the_wall"
    t.string   "deposit_module"
    t.string   "cash_box_qty"
    t.string   "touch_screen"
    t.string   "system"
    t.string   "monitor"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_readers", :force => true do |t|
    t.string   "card_type"
    t.string   "read_write"
    t.string   "interface"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_types", :force => true do |t|
    t.string   "name"
    t.string   "table"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.integer  "no"
    t.string   "brand"
    t.string   "sn"
    t.string   "device_type"
    t.string   "model"
    t.string   "admin"
    t.string   "department"
    t.date     "start_using_time"
    t.date     "end_server_time"
    t.string   "status"
    t.integer  "detail_id"
    t.string   "detail_type"
    t.string   "device_provider"
    t.string   "service_provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disk_arrays", :force => true do |t|
    t.integer  "max_capacity"
    t.integer  "slot_qty"
    t.string   "interface"
    t.integer  "mtbf"
    t.integer  "baud_rate"
    t.integer  "cache"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "firewalls", :force => true do |t|
    t.integer  "port_qty"
    t.integer  "user_qty"
    t.string   "vpn"
    t.integer  "security_filtering"
    t.integer  "throughput"
    t.integer  "max_client"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generators", :force => true do |t|
    t.integer  "voltage"
    t.integer  "power"
    t.string   "fuel_type"
    t.integer  "discharge_time"
    t.integer  "oil_capacity"
    t.string   "starting_method"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_banlancers", :force => true do |t|
    t.integer  "mem"
    t.integer  "port_qty"
    t.string   "cpu"
    t.integer  "cpu_qty"
    t.integer  "power_module_qty"
    t.string   "layer"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pin_pads", :force => true do |t|
    t.string   "interface"
    t.string   "voice"
    t.string   "anti_peep_cover"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "printers", :force => true do |t|
    t.string   "printer_method"
    t.string   "printer_type"
    t.string   "color"
    t.string   "interface"
    t.string   "net_module"
    t.string   "duplex_printing"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.string   "addr"
    t.string   "contact"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fault_rate"
    t.string   "fix_on_time_rate"
  end

  create_table "routers", :force => true do |t|
    t.integer  "mem"
    t.integer  "total_backplane_bandwidth"
    t.string   "modularization"
    t.integer  "wan_port_qty"
    t.integer  "lan_port_qty"
    t.integer  "power_module_qty"
    t.integer  "slot_qty"
    t.string   "vpn"
    t.string   "qos"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_changes", :force => true do |t|
    t.integer  "device_id"
    t.date     "status_change_time"
    t.string   "status"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "service_provider"
    t.string   "department"
  end

  create_table "switches", :force => true do |t|
    t.string   "switch_type"
    t.integer  "mem"
    t.integer  "total_backplane_bandwidth"
    t.string   "modularization"
    t.string   "port_type"
    t.integer  "port_rate"
    t.integer  "port_qty"
    t.string   "layer"
    t.string   "vlan"
    t.integer  "power_module_qty"
    t.integer  "slot_qty"
    t.string   "stack"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ups", :force => true do |t|
    t.integer  "rated_capacity"
    t.integer  "output_voltage"
    t.integer  "input_voltage"
    t.integer  "voltage_range"
    t.integer  "backup_time"
    t.integer  "transition_time"
    t.string   "ups_type"
    t.integer  "link_qty"
    t.integer  "battery_voltage"
    t.integer  "battery_capacity"
    t.string   "battery_model"
    t.string   "battery_brand"
    t.integer  "battery_qty_per_group"
    t.integer  "battery_group"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "userid"
    t.string   "hashed_password"
    t.string   "department"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

end
