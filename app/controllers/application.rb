# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
#  before_filter :authorize, :except => :login

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '547dd7db38f86307693e16e7d12e4edc'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password


  #根据给出的node，找出所有下属节点，is_show_self为true时，结果中包含node本身；返回值是一个数组
  def get_subtree(node,indent=false,level=0)
    node_list=[node]
    node.children.each do |item|
      item.name="　"*2*level+item.name if indent
      node_list+=get_subtree(item,indent,level+1)
    end
    return node_list
  end

  #获取当前用户名称
  def current_user
    User.find(session[:user_id]).name
  end

  def department
    User.find(session[:user_id]).department
  end
  #当前用户所属部门及所有下属部门，是一个Department的数组
  def departments(department=nil)
    department=User.find_by_name(current_user).department if department.nil?
    node=Department.find_by_name(department)
    get_subtree(node)
  end
  
  #  取出数据库表中的设备类型
  def device_types
    DeviceType.find(:all).find_all{ |i| i.parent_id != nil }
  end

  #基于will_paginate插件的数组分页方法
  def array_paginate(array,per_page)
    params[:page]||=1
    return WillPaginate::Collection.create(params[:page], per_page) do |pager|
      result = array[pager.offset,pager.per_page]
      pager.replace(result)

      unless pager.total_entries
        pager.total_entries = array.size
      end
    end
  end

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "您还没有登录，请先登录！"
      redirect_to :controller => 'admin', :action => 'login'
    end
  end

  private
  #为了让其他控制器类也能够使用这段代码，将其放在所有控制器共有的父类ApplicationController中
  def find_like(params) #params是一个Hash, 存放着字段名和查询条件
    # 通过Hash的map方法将键值对转成" key like '%value%'"的字符串数组，再通过join方法将这些字符串数组用" and "连接起来，从而形成一个完整的查询条件。
    #这里的ActiveRecord::Base.connection.quote是Rails提供的一个接口，将引号转为特定数据库所需要的形式。
    params.map {  |key,value|
      "#{key} like " + ActiveRecord::Base.connection.quote("%#{value}%")
    }.join(" and ")
  end
end

class Array
  def names
    self.map(&:name)
  end
end