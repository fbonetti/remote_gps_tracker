class CoordinatePresenter < SimpleDelegator

  def formatted_location
    "#{location.primary_city}, #{location.state} #{location.zip}"
  end

  def formatted_gps_timestamp
    gps_timestamp.in_time_zone('US/Central').strftime("%-l:%M %p %Z - %B %d, %Y")
  end
end
