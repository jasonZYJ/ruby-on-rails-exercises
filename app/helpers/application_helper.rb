module ApplicationHelper
  def admin_date_format(date)
    date.strftime('%b %d, %Y') if date
  end

  def assigned_orders
    @assigned_orders ||= current_employee.assigned_orders.paid.unfinished
  end
end
