class Device < ActiveRecord::Base
  validates_presence_of :no,:brand,:department,:status,:device_type
  #  validates_presence_of :sn, :if => Proc.new{|u| p u}
  validates_numericality_of :no,:only_integer=>'true'
  validates_uniqueness_of :no  #,:sn
  has_one :accessory_equipment
  has_one :network

  has_many :status_change,:dependent=>:delete_all


  belongs_to :detail, :polymorphic => true
  STATUS=["未领用","在用","故障","维修","停用","备用","报废"]
  SUB_TYPE=["小型机","服务器","个人计算机","笔记本电脑","终端"]
end
