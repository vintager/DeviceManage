class ReportController < ApplicationController
  #按部门统计设备数量
  def device_count_report_by_department
    @list = device_count_report_data_by_department(Department.find_by_name("青海省邮政公司"))

    render_with("设备数量统计表（按部门分类）","部门")
  end
#按厂商统计设备数量
  def device_count_report_by_provider
    #一个维数组，用来存放报表数据，每个数组元素由两项数据组成，第一个是厂商名称，第二个是一个数组，包含厂商提供的各种设备数量和设备总数
    @list=[]

    Provider.find(:all).each do |p|
      count=[]
      device_types.names.each do |type|
        count<<Device.count(:conditions=>["device_type=? and device_provider = ?",type,p.name])
      end
      count<< count.sum
      @list<<[p.name,count]
    end

    render_with("设备数量统计表（按厂商分类）","厂商")
  end

  #按部门统计故障次数
  def fault_count_report_by_department
    @list = fault_count_report_data_by_department(Department.find_by_name("青海省邮政公司"))

    render_with("设备故障次数统计表（按部门分类）","部门")
  end

  #按厂商统计故障次数
  def fault_count_report_by_provider
    @list=[]

    Provider.find(:all).each do |p|
      count=[]
      device_types.names.each do |type|
        count<<Device.count(:joins=>"INNER JOIN status_changes on status_changes.device_id = devices.id",
          :conditions=>["device_type=? and device_provider = ? and status_changes.status=?",type,p.name,"故障"])
      end
      count<< count.sum
      @list<<[p.name,count]
    end

    render_with("设备故障次数统计表（按厂商分类）","厂商")
  end
#生成按部门统计设备数量相关数据
  def device_count_report_data_by_department(node,level=0)
    #定义一个数组，其中前几项用来存放某部门各种设备的数量，最后一项存放该部门所有设备总数
    count=[]
    
    #统计某个部门设备总数，分类型
    device_types.names.each do |type|
      count<<Device.count(:conditions=>["device_type=? and department in (?)",type,get_subtree(node).names])
    end
    #计算出该部门所有类型设备总数
    count<<count.sum

    #为了让统计报表能够按照部门级别显示，在下级部门前增加全角空格
    node_list=[["　"*2*level+node.name,count]]

    if node.children.size>0 then
      # 如果该部门有下级部门，添加"本部"标识
      count=[]
      device_types.names.each do |type|
        count<<Device.count(:conditions=>["device_type=? and department = ?",type,node.name])
      end
      count<<count.sum

      node_list+=[["　"*2*(level+1)+node.name+"本部",count]]
      node.children.each do |item|
        node_list += device_count_report_data_by_department(item,level+1)
      end
    end

    node_list
  end

  #生成按部门统计故障次数相关数据
  def fault_count_report_data_by_department(node,level=0)
    #定义一个数组，其中前几项用来存放某部门各种设备的故障次数，最后一项存放该部门所有设备故障总数
    count=[]

    #统计某个部门设备故障总数，分类型
    device_types.names.each do |type|

      count<<Device.count(:joins=>"INNER JOIN status_changes on status_changes.device_id = devices.id",
        :conditions=>["device_type=? and status_changes.department in (?) and status_changes.status=?",type,get_subtree(node).names,"故障"])
    end

    #计算出该部门所有类型设备故障总数
    count<<count.sum

    #为了让统计报表能够按照部门级别显示，在下级部门前增加全角空格
    node_list=[["　"*2*level+node.name,count]]

    if node.children.size>0 then
      # 如果该部门有下级部门，添加"本部"标识
      count=[]
      device_types.names.each do |type|
        count<<Device.count(:joins=>"INNER JOIN status_changes on status_changes.device_id = devices.id",
          :conditions=>["device_type=? and status_changes.department = ? and status_changes.status=?",type,node.name,"故障"])
      end
      count<<count.sum

      node_list+=[["　"*2*(level+1)+node.name+"本部",count]]
      node.children.each do |item|
        node_list += fault_count_report_data_by_department(item,level+1)
      end
    end

    node_list
  end


  private

  def render_with(table_name="统计报表",first_of_table_head="项目")
    @table_name = table_name
    @first_of_table_head = first_of_table_head

    render :action => "device_report"
  end
end
