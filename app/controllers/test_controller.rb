class TestController < ApplicationController
  def index
    a=Department.find_by_name('xn')
    p a
    p "-----"
    s=a.superior
#    j=a.junior
    p s.name
#    p j.name
  end
end
