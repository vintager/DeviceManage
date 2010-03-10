class Createtables < ActiveRecord::Migration
  def self.up
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
    
    create_table "users", :force => true do |t|
      t.string   "name"
      t.string   "userid"
      t.string   "hashed_password"
      t.string   "department"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "salt"
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
      t.integer  "state_change_id"
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
      t.text     "memo"
      t.text "display"
      t.datetime "created_at"
      t.datetime "updated_at"
      
    end

    create_table "providers", :force => true do |t|
      t.string   "name"
      t.string   "addr"
      t.string   "contact"
      t.string   "phone"
      t.integer  "rank"
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
    end

    create_table "switches", :force => true do |t|
      t.integer  "port"
      t.integer  "layer"
      t.integer  "speed"
      t.integer  "back_speed"
      t.text     "memo"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end

  def self.down
    drop_table :departments
    drop_table :device_types
    drop_table :users
    drop_table :devices
    drop_table :computer_details
    drop_table :providers
    drop_table :status_changes
    drop_table :switches

  end
end
