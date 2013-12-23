class CoordinatesController < ApplicationController

  def index
    @dates = Coordinate.unique_dates
    @coordinate_array = Coordinate.all.map { |coordinate| [coordinate.latitude, coordinate.longitude] }
    @latest_coordinate = Coordinate.eager_load(:location).last
  end

  def create
    latitude, longitude, altitude, date, time = params[:Body].split(",")
    gps_timestamp = DateTime.strptime(date + time, "%d%m%y%H%M%S%L")

    Coordinate.create(
      latitude: latitude.to_f, longitude: longitude.to_f,
      altitude: altitude.to_f, gps_timestamp: gps_timestamp
    )

    render nothing: true, status: 200
  end

end
