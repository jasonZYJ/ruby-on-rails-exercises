module ApplicationHelper
  def admin_date_format(date)
    date.strftime('%b %d, %Y') if date
  end
end
