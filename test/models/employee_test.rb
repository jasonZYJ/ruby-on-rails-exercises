require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  test 'orders have assigned employees' do
    employee = FactoryGirl.create(:employee)
    order1 = FactoryGirl.create(:order)
    order2 = FactoryGirl.create(:order, assigned_to: employee)

    assert_equal [order2], employee.assigned_orders
  end
end
