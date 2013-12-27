class Coordinate < ActiveRecord::Base
  validates :latitude,  numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :altitude,  numericality: { less_than: 1000000 }
  validates :gps_timestamp, presence: true

  belongs_to :location

  before_create :find_location

  US_CENTRAL = 'US/Central'

  def self.find_by_date(date, timezone = US_CENTRAL)
    Coordinate.where("(gps_timestamp::timestamptz at time zone ?)::date = ?", timezone, date)
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
             (select extract(epoch from max(c2.gps_timestamp) - min(c1.gps_timestamp))/3600) as kmh
      FROM rows c1
      JOIN rows c2 on c1.rn = c2.rn - 1;
    ").first["kmh"].to_f
  end

  def self.average_mph
    km_to_miles(average_kmh)
  end

  # Measures the delay between when a gps data point is initially collected and
  # subsequently stored in the datebase
  def self.average_transmission_delay
    Coordinate.average("date_part('epoch', created_at) - date_part('epoch', gps_timestamp)").to_f
  end

  # Central Time Zone
  def self.unique_dates(timezone = US_CENTRAL)
    Coordinate.select("(gps_timestamp::timestamptz at time zone '#{timezone}')::date as date").distinct.map(&:date).sort.reverse
  end

  private

  def self.km_to_miles(km)
    km * 0.621371
  end

  def find_location
    self.location_id  = Location.select(:id)
                                .order("geodistance_km(#{self.latitude.to_f}, #{self.longitude.to_f}, latitude, longitude)")
                                .limit(1).first.id
  end

end
