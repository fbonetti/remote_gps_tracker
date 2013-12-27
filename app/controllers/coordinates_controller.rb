class CoordinatesController < ApplicationController

  def index
    @unique_dates = Coordinate.unique_dates
    coordinates = (params[:date] ? Coordinate.find_by_date(params[:date]) : Coordinate.all)
    @coordinate_array = coordinates.map { |coordinate| [coordinate.latitude, coordinate.longitude] }
    @latest_coordinate = CoordinatePresenter.new(Coordinate.eager_load(:location).last)
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
