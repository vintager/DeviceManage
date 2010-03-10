class ComputerDetail < ActiveRecord::Base
  has_one :device, :as => :detail,:dependent=>:destroy

  validates_presence_of :cpu,:cpu_qty,:mem,:nic,:nic_qty,:disk,:disk_qty
  validates_numericality_of :cpu_qty,:mem,:nic_qty,:disk,:disk_qty,:only_integer=>'true'
end
