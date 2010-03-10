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
    @device_detail.attributes = params[:device_type]
    unless [@device, @device_detail].map(&:valid?).include?(false)
      @device.update_attributes(params[:device])
      @device_detail.update_attributes(params[:device_type])
      flash[:notice] = '新设备已经修改成功！'
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
    params[:device][:status] = params[:status_change][:status]
    @device.attributes = params[:device]
    
    @status_change = StatusChange.new(params[:status_change])
    @status_change.device_id=@device.id
    
    unless [@device, @status_change].map(&:valid?).include?(false)
      @device.update_attributes(params[:device])
      @status_change.save
      flash[:notice] = '新设备状态已经修改成功！'
      redirect_to :id=>@device, :action=>"show_status_change"
    else
      render :action => "change_status"
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
  end
  
  def query
    conds = Hash.new
    params[:device].each do |key, value|
      conds.store(key, value) unless value.blank?
    end
    conds["department"]=departments.names if conds["department"].blank?
    @devices = Device.paginate(:all, :conditions=>conds,:per_page => 20, :page => params[:page])
    
    render :action => "index"
  end
  
  #获取将要新增设备的类型
  def select_type
    @device_type=DeviceType.find_by_name(params[:device_type]).table
    @device_detail = Object.const_get(@device_type.classify).new
  end

  def batch_input
    @device = Device.new
    @provider=Provider.find(:all)

    #设备详情
    @device_detail=ComputerDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @device }
    end
  end

  def batch_keep_device
    p params
    @device_type=DeviceType.find_by_name(params[:device][:device_type]).table
    p @device_type
    session[:device_detail]=params[@device_type]
    p session[:device_detail]
    session[:batch_device]=params[:device]
    p  session[:batch_device]
    render :action => "select_departments"
  end

  def batch_create
    @devices=[]
    params[:department_ids].each do |id|
      p id
      #      p session[:batch_device]
      session[:batch_device][:no] = device_no
      p Department.find(id).name
      session[:batch_device][:department]=Department.find(id).name
      #      p session[:batch_device]
      #      p session[:device_detail]
      @device = Device.new(session[:batch_device])
      
      #根据下拉列表中的设备类型创建一个设备详情表
      @device_type=DeviceType.find_by_name(session[:batch_device][:device_type]).table
      #      p @device_type
      @device_detail = Object.const_get(@device_type.classify).new(session[:device_detail])
      
      @device.detail = @device_detail
      @device.save!
      @devices<<@device
    end
    session[:batch_device]=nil

    @devices = array_paginate(@devices, 20)
    flash[:notice] = '批量增加设备成功！'
    render :action => "batch_show"
  end
  
  private
  def find_detail
    @device = Device.find(params[:id])  #根据设备id值查找设备
    @device_type=@device.detail_type.underscore
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
end

