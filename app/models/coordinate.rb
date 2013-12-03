class Coordinate < ActiveRecord::Base
  validates :latitude,  numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :altitude,  numericality: true
  validates :timestamp, presence: true

  US_CENTRAL = 'US/Central'

  def self.find_by_date(date, timezone = US_CENTRAL)
    Coordinate.where("(timestamp::timestamptz at time zone ?)::date = ?", timezone, date)
  end

  def self.total_km_travelled
    ActiveRecord::Base.connection.execute("
      WITH ROWS AS
      (
        SELECT *, row_number() over (order by created_at) as rn
        FROM coordinates
      )
      SELECT sum(geodistance_km(c1.latitude, c1.longitude, c2.latitude, c2.longitude)) as km
      FROM rows c1
      JOIN rows c2 on c1.rn = c2.rn - 1;
    ").first["km"].to_f
  end

  def self.total_miles_travelled
    km_to_miles(total_km_travelled)
  end

  def self.average_kmh
    ActiveRecord::Base.connection.execute("
      WITH ROWS AS
      (
        SELECT *, row_number() over (order by created_at) as rn
        FROM coordinates
      )
      SELECT sum(geodistance_km(c1.latitude, c1.longitude, c2.latitude, c2.longitude)) /
             (select extract(epoch from max(c2.timestamp) - min(c1.timestamp))/3600) as kmh
      FROM rows c1
      JOIN rows c2 on c1.rn = c2.rn - 1;
    ").first["kmh"].to_f
  end

  def self.average_mph
    km_to_miles(average_kmh)
  end

  # Measures the delay between when a gps data point is initially, sent to Twilio,
  # and then finally stored in the database
  def self.average_transmission_delay
    Coordinate.average("date_part('epoch', created_at) - date_part('epoch', timestamp)").to_f
  end

  # Central Time Zone
  def self.unique_dates(timezone = US_CENTRAL)
    Coordinate.select("(timestamp::timestamptz at time zone '#{timezone}')::date as date").distinct.map(&:date).sort
  end

  private

  def self.km_to_miles(km)
    km * 0.621371
  end

end
