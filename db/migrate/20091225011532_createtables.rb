class Createtables < ActiveRecord::Migration
  def self.up
    create_table "departments", :force => true do |t|
      t.string   "name"
      t.integer  "parent_id"
      t.string   "contact"
      t.string   "phone"
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
      t.date     "acquisition_time"
      t.date     "end_server_time"
      t.string   "status"
      t.integer  "detail_id"
      t.string   "device_provider"
      t.string   "service_provider"
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

  def self.down
    drop_table :departments
    drop_table :device_types
    drop_table :providers
    drop_table :status_changes
    drop_table :users
    drop_table :devices
  end
end
