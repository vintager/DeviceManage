class Device < ActiveRecord::Base
  attr_accessor :batch
  validates_presence_of :brand,:model,:status,:device_type
  validates_presence_of :no,:sn,:department, :if=> Proc.new{|u| !u.batch==true }
  validates_numericality_of :no,:only_integer=>'true', :if=> Proc.new{|u| !u.batch==true }
  validates_uniqueness_of :no ,:sn, :if=> Proc.new{|u| !u.batch==true }

  has_many :status_change,:dependent=>:delete_all

  belongs_to :detail, :polymorphic => true
  STATUS=["未领用","在用","故障","维修","停用","备用","报废"]
  SUB_TYPE=["小型机","服务器","个人计算机","笔记本电脑","终端"]

end
