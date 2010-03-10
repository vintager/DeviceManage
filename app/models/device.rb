class Device < ActiveRecord::Base
  validates_presence_of :no,:brand,:department,:status,:device_type
  #  validates_presence_of :sn, :if => Proc.new{|u| p u}
  validates_numericality_of :no,:only_integer=>'true'
  validates_uniqueness_of :no  #,:sn
  has_one :accessory_equipment
  has_one :network
#  acts_as_reportable


  belongs_to :detail, :polymorphic => true
  STATUS=["未领用","在用","维修","停用","报废"]
  SUB_TYPE=["小型机","服务器","个人计算机","笔记本电脑","终端"]
end
