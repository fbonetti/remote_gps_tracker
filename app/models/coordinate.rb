class Coordinate < ActiveRecord::Base
  validates :latitude,  numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :altitude,  numericality: true
  validates :timestamp, presence: true

  def self.total_km_travelled
    ActiveRecord::Base.connection.execute("
      WITH ROWS AS
      (
        SELECT *, row_number() over (order by created_at) as rn
        FROM coordinates
      )
      SELECT sum(geodistance_km(c1.latitude, c1.longitude, c2.latitude, c2.longitude)) as miles
      FROM rows c1
      JOIN rows c2 on c1.rn = c2.rn - 1;
    ").first["miles"].to_f
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
             (select extract(epoch from max(c2.timestamp) - min(c1.timestamp))/3600) as mph
      FROM rows c1
      JOIN rows c2 on c1.rn = c2.rn - 1;
    ").first["mph"].to_f
  end

  def self.average_mph
    km_to_miles(average_kmh)
  end

  def self.average_transmission_delay
    Coordinate.average("date_part('epoch', avg(timestamp - created_at))").to_f
  end

end
