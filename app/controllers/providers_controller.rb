class ProvidersController < ApplicationController
  # GET /providers
  # GET /providers.xml
  def index
    @providers = Provider.paginate(:per_page => 20, :page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.xml
  def show
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.xml
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.xml
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        flash[:notice] = '厂商成功创建！'
        format.html { redirect_to(@provider) }
        format.xml  { render :xml => @provider, :status => :created, :location => @provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.xml
  def update
    @provider = Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        flash[:notice] = '厂商信息修改成功！'
        format.html { redirect_to(@provider) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.xml
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to(providers_url) }
      format.xml  { head :ok }
    end
  end

  def get_query
    @provider = Provider.new
  end


  def query
    conds = Hash.new
    params[:provider].each do |key, value|
      conds.store(key, value) unless value.blank?
    end

    @providers = Provider.paginate(:all, :conditions=>find_like(conds).to_s,:per_page => 20, :page => params[:page])

    render :action => "index"
  end

  def get_fault_rate(provider)
    #统计该厂商发生过故障的设备数量
    fault_count=Device.count(:joins=>"INNER JOIN status_changes on status_changes.device_id = devices.id",
      :select=>"device_id",
      :distinct=>"devices.id",
      :conditions=>["device_provider = ? and status_changes.status=?",provider,"故障"])
    #统计该厂商提供的所有设备总数
    device_count=Device.find_all_by_device_provider(provider).size
    #计算该厂商设备故障率
    device_count!=0 ? fault_count.to_f/device_count : "-"
  end

  def get_fix_on_time_rate(provider)
    #统计该厂商维修过的设备次数
    fix_log = StatusChange.find_all_by_service_provider_and_status(provider,"维修",:order=>:status_change_time)
    status_log = StatusChange.find_all_by_service_provider(provider,:order=>:status_change_time)
    fix_on_time=0
    if fix_log.size>0
      fix_log.each do |item|
        status_log.each do |i|
          if (i.status_change_time >= item.status_change_time) && (i.id!=item.id) && (i.device_id==item.device_id) 
            fix_on_time += 1 if (i.status_change_time-item.status_change_time).to_i < FIX_TIME_LIMIT
            break;
          end
        end
      end
      fix_on_time/fix_log.size.to_f
    else
      "-"
    end
  end

  def rank
    providers = Provider.find(:all)
    providers.each do |provider|
      rate = get_fault_rate(provider.name)
      provider.fault_rate = in_percent(rate)
      rate = get_fix_on_time_rate(provider.name)
      provider.fix_on_time_rate = in_percent(rate)

      provider.save
    end

    redirect_to :action => "index"
  end

  private
  def in_percent(rate)
    rate.kind_of?(Numeric) ? sprintf("%.2f%",rate*100) : "-"
  end
  
end
