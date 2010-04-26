# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style" ] = "display: none"
    end
    content_tag("div" , attributes, &block)
  end
  #  #在ApplicationController中有重复定义，不知如何去除

  def revtree(node,parent)
    tree="var tree#{node.id} = new WebFXTreeItem(\"#{node.name}\",\"javascript:openWin(treeroot)\" );\n"
    node.children.each do|child|
      tree << revtree(child,"tree#{node.id}")
    end
    tree << parent + ".add(tree#{node.id});\n"
    return tree;
  end

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
  #当前用户所属部门及所有下属部门以及直接上级，是一个Department的数组
  def parent_and_departments
    department=User.find_by_name(current_user).department
    node=Department.find_by_name(department)
    get_subtree(node)<<node.parent if node.parent
  end
  #返回名字数组
  def names(arr)
    arr.map(&:name)
  end
  #取出数据库表中的设备类型
  def device_types
    DeviceType.find(:all).find_all{ |i| i.parent_id != nil }
  end

end

