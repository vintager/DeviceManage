class Switch < ActiveRecord::Base
  validates_presence_of :back_speed
  validates_numericality_of :back_speed,:only_integer=>'true'
end
