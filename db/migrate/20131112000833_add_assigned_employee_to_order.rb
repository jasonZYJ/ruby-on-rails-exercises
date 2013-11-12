class AddAssignedEmployeeToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :assigned_to
  end
end
