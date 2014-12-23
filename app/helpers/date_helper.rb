module DateHelper

  def date_with_time(date)
    date.try(:strftime, '%d.%m.%Y %H:%M')
  end
end
