class AddCustomGeodistanceFunctions < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute("
      CREATE OR REPLACE FUNCTION public.geodistance_km(alat double precision, alng double precision, blat double precision, blng double precision)
        RETURNS double precision AS
      $BODY$
      SELECT asin(
        sqrt(
          sin(radians($3-$1)/2)^2 +
          sin(radians($4-$2)/2)^2 *
          cos(radians($1)) *
          cos(radians($3))
        )
      ) * 12756.2 AS distance;
      $BODY$
        LANGUAGE sql IMMUTABLE
        COST 100;
    ")
  end
end
