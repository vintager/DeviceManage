class MaintainController < ApplicationController
  def index
    @device_ids=StatusChange.find_by_sql("select distinct device_id from status_changes where status='维修'").map { |i| i.device_id }
    device_maintain_log = Array.new
    @device_ids.each do |device_id|
      device_key=Device.find_by_no(device_id)
      device_value=StatusChange.find_all_by_device_id(device_id,:order=>"status_change_time,id")
      device_maintain_log<< (Hash[device_key,device_value])
    end
    @device_maintain_log = array_paginate(device_maintain_log,20)
  end
end
