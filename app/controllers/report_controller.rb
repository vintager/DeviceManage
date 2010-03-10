class ReportController < ApplicationController
  def device_type_report
#    @a = Device.report_table.to_html
  end

  def device_department_report
    @department = get_department_report_data(Department.find_by_name("青海省邮政公司"))
  end

  def device_provider_report
    @list=[]
    
    Provider.find(:all).each do |p|
      count=[]
      device_types.names.each do |type|
        count<<Device.count(:conditions=>["device_type=? and device_provider = ?",type,p.name])
      end
      count<<Device.count(:conditions=>["device_provider = ?",p.name])
      @list<<[p.name,count]
    end

    p @list
  end

  def device_maintain_report
  end

  def get_department_report_data(node,level=0)
    count=[]
    device_types.names.each do |type|
      count<<Device.count(:conditions=>["device_type=? and department in (?)",type,get_subtree(node).names])
    end
    count<<Device.count(:conditions=>["department in (?)",get_subtree(node).names])
    node_list=[[node,count]]
    
    if node.children.size>0 then
      node_self=node.clone
      node_self.name=node_self.name+"本部"
      temp_count=[]
      device_types.names.each do |type|
        temp_count<<Device.count(:conditions=>["device_type=? and department = ?",type,node.name])
      end
      temp_count<<Device.count(:conditions=>["department = ?",node.name])
      
      node_list+=[[node_self,temp_count]]
      node.children.each do |item|
        item.name="　"*2*level+item.name
        node_list += get_department_report_data(item,level+1)
      end
    end
    return node_list
  end

end
