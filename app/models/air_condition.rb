class AirCondition < ActiveRecord::Base
  has_one :device, :as => :detail,:dependent=>:destroy
end
