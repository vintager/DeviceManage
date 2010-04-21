class Switch < ActiveRecord::Base
  has_one :device, :as => :detail,:dependent=>:destroy

#  validates_presence_of :back_speed
#  validates_numericality_of :back_speed,:only_integer=>'true'
end
