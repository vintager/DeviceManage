#部门对应的模型类
class Department < ActiveRecord::Base
  #加入了acts_as_tree，为了让各个部门每次显示的位置能够保持不变，按照id字段做了排序
  acts_as_tree :order=>:id
  validates_presence_of :name,:address
  validates_presence_of :parent, :if => Proc.new{|u| !(u.name=="中国邮政集团公司")}
  validates_uniqueness_of :name
  validate :leader_member_relation, :if => Proc.new{|u| !(u.name=="中国邮政集团公司")}

  ROOT="中国邮政集团公司"

  protected

  # 判断是否存在上下级关系错误的情况，判断的方法是查询该部门的所有上级部门，如果查到上级部门中有本部门，就说明有错误发生，如果查到最高一级还没有发现这种情况，则认为该记录合法，可以写入数据库中。

  def leader_member_relation
    node=self
    while node.parent
      node=node.parent
      if node.id==self.id
        errors.add("","上下级关系错")
        break
      end
    end
  end
end
