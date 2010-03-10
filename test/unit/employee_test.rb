require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  e1=Employee.create(:name=>"zhang")
  e2=Employee.create(:name=>"li")
  e3=Employee.create(:name=>"wang",:manager_id=>1)
end
