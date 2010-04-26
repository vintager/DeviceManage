class DevicesController < ApplicationController
  #  before_filter :have_right?, :except=>[:new, :create,:index, :list,:get_query,:query,:select_type,:find_detail,:device_no]

  # GET /devices
  # GET /devices.xml
  def index
    @devices = Device.paginate_all_by_department(departments.names,:per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @devices }
    end
  end

  # GET /devices/1
  # GET /devices/1.xml
  def show
    find_detail
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @device }
    end
  end

  
  # GET /devices/new
  # GET /devices/new.xml
  def new
    #获取设备编号
    @device = Device.new
    @device.no = device_no
    @provider=Provider.find(:all)

    #设备详情
    @device_detail=ComputerDetail.new
    @device_type="computer_detail"
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @device }
    end
  end

  # GET /devices/1/edit
  def edit
    find_detail
    @provider=Provider.find(:all)
  end

  # POST /devices
  # POST /devices.xml

  def create
    @device = Device.new(params[:device])
    #根据下拉列表中的设备类型创建一个设备详情表
    @device_type=DeviceType.find_by_name(params[:device][:device_type]).table
    @device_detail = Object.const_get(@device_type.classify).new(params[@device_type])

    unless [@device, @device_detail].map(&:valid?).include?(false)
      @device_detail.save
      @device.detail = @device_detail
      @device.save
      flash[:notice] = '新设备已经添加成功！'
      redirect_to(@device)
    else
      @provider=Provider.find(:all)
      render :action => "new"
    end
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    find_detail
    
    @device.attributes = params[:device]
    @device_type=DeviceType.find_by_name(params[:device][:device_type]).table
    @device_detail.attributes = params[@device_type]
    unless [@device, @device_detail].map(&:valid?).include?(false)
      @device.update_attributes!(params[:device])
      @device_detail.update_attributes!(params[@device_type])
      flash[:notice] = '设备参数修改成功！'
      redirect_to(@device)
    else
      @provider=Provider.find(:all)
      render :action => "edit"
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device = Device.find(params[:id])  #根据设备id值查找设备
    @device_detail=@device.detail.destroy
    respond_to do |format|
      format.html { redirect_to(devices_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def list
    dept_for_currentuser=departments.names
    if  dept_for_currentuser.include?(params[:id])
      dept_name=departments(params[:id]).names
    else
      dept_name=dept_for_currentuser
    end
    @devices=Device.paginate_all_by_department(dept_name,:per_page => 20, :page => params[:page])
    
    render :action => "index"
  end

  # GET /devices/change_status
  def change_status
    @device = Device.find(params[:id])  #根据设备id值查找设备
    @departments=departments.names #获取部门列表
    @status_change = StatusChange.new
    render :action => "change_status"
  end

  # POST /devices/1/update_status
  # POST /devices/1.xml
  def update_status
    find_detail
    #如果更改状态的时间比数据库中该设备最后更改的时间还早的话，说明日期有错误
    last_record=StatusChange.find_by_device_id(@device.id,:order=>"status_change_time DESC")

    if last_record.blank?
      max_date=Date.parse("1970-1-1") 
      pro_status = ""
    else 
      max_date=last_record.status_change_time
      pro_status = last_record.status
    end

    if Date.parse(params[:status_change][:status_change_time])>max_date
      if params[:status_change][:status]=="维修" && pro_status!="故障"
        flash[:notice] = '有故障的设备才能维修！'
        redirect_to :action=>:change_status
      else
        params[:device][:status] = params[:status_change][:status]
        @device.attributes = params[:device]

        @status_change = StatusChange.new(params[:status_change])
        @status_change.device_id = @device.id
        @status_change.service_provider = @device.service_provider
        @status_change.department = @device.department

        unless [@device, @status_change].map(&:valid?).include?(false)
          @device.update_attributes(params[:device])
          @status_change.save
          flash[:notice] = '新设备状态已经修改成功！'
          redirect_to :id=>@device, :action=>"show_status_change"
        else
          render :action => "change_status"
        end
      end
    else
      flash[:notice] = '日期错误！'
      redirect_to :action=>:change_status
      
    end
  end

  def show_status_change
    find_detail
    
    @status_change=StatusChange.find_by_device_id(@device.id,:order => "updated_at DESC")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @device }
    end
  end

  def get_query
    @device = Device.new
    @time_range = Date.new
  end
  
  def query
    conds = []
    if params[:device][:department].blank?
      conds<<"department in (?)"
      conds<<departments.names 
    else
      conds<<"department = ?"
      params[:device][:department]
    end
    
    params[:device].each do |key, value|
      unless value.blank?
        conds[0]=conds[0]+" and #{key} = ?"
        conds<<value
      end
    end

    add_condition(conds,"acquisition_time>=",params[:date][:acquisition_time_from])
    add_condition(conds,"acquisition_time<=",params[:date][:acquisition_time_to])
    add_condition(conds,"end_server_time>=",params[:date][:end_server_time_from])
    add_condition(conds,"end_server_time<=",params[:date][:end_server_time_to])
    @devices = Device.paginate(:all, :conditions=>conds,:per_page => 20, :page => params[:page])
    
    render :action => "index"
  end
  
  #获取将要新增设备的类型
  def select_type
    @device_type = DeviceType.find_by_name(params[:device_type]).table
    @device_detail = Object.const_get(@device_type.classify).new(params[@device_type])
  end

  def batch_input
    clear_batch_session
    
    batch_data
  end

  def batch_keep_device
    @device_type = session[:device_type] = DeviceType.find_by_name(params[:device][:device_type]).table
    @device=Device.new(params[:device])
    @device.batch=true

    session[:device_detail]=params[session[:device_type]]
    session[:batch_device]=params[:device]
    #根据下拉列表中的设备类型创建一个设备详情表
    @device_detail = Object.const_get(session[:device_type].classify).new(session[:device_detail])

    unless [@device, @device_detail].map(&:valid?).include?(false)
      render :action => "select_departments"
    else
      @provider=Provider.find(:all)
      render  :action => :batch_input
    end
  end

  def batch_create
    @devices=[]
    params[:department_ids].each do |id|
      session[:batch_device][:department]=Department.find(id).name
      qty = params["qty_#{id}"].to_i
      qty.times do |i|
        session[:batch_device][:no] = device_no
        @device = Device.new(session[:batch_device])
        @device.batch=true
      
        #根据下拉列表中的设备类型创建一个设备详情表
        @device_detail = Object.const_get(session[:device_type].classify).new(session[:device_detail])
        @device.detail = @device_detail
        
        @device.save!
      end
      @devices<<[@device,qty]
    end
    
    clear_batch_session

    @devices = array_paginate(@devices, 20)
    flash[:notice] = '批量增加设备成功！'
    render :action => "batch_show"
  end

  def batch_data
    @device = Device.new(session[:batch_device])||Device.new
    @provider=Provider.find(:all)

    #设备详情
    @device_detail = session[:device_type] == nil ? ComputerDetail.new : Object.const_get(session[:device_type].classify).new(session[:device_detail])
    @device_type = session[:device_type] || "computer_detail"

    render  :action => :batch_input
  end
  
  private
  def find_detail
    @device = Device.find(params[:id])  #根据设备id值查找设备
    @device_type = DeviceType.find_by_name(@device.device_type).table
    @device_detail=@device.detail
  end

  def have_right?
    unless departments.names.include?(Device.find(params[:id]).department) then
      @devices=""
      render :action => "index"
    end
  end

  #获取设备编号
  def device_no
    no = Device.maximum(:no)
    if no
      no+1
    else
      1
    end
  end
  
  def clear_batch_session
    session[:batch_device]=nil
    session[:device_detail]=nil
    session[:device_type]=nil
  end

  def add_condition(conds,condition, value)
    if !value.blank?
      conds[0] = conds[0]+" and #{condition}  ?"
      conds << Date.parse(value)
    end
  end
end

