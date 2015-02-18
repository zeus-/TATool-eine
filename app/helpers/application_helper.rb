module ApplicationHelper
  
  def formatted_date(date) 
    date.strftime("%m-%d-%Y") if date
  end

end
