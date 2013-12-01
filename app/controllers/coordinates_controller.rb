class CoordinatesController < ApplicationController

  def index
    @coordinates = Coordinate.all
  end

  def create
    latitude, longitude, altitude, date, time = params[:Body].split(",")
    timestamp = DateTime.strptime(date + time, "%d%m%y%H%M%S%L")

    Coordinate.create(
      latitude: latitude.to_f, longitude: longitude.to_f,
      altitude: altitude.to_f, timestamp: timestamp
    )

    render nothing: true, status: 200
  end

end
