class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :zip
      t.string :type
      t.string :primary_city
      t.string :acceptable_cities
      t.string :unacceptable_cities
      t.string :state
      t.string :county
      t.string :timezone
      t.string :area_codes
      t.decimal :latitude
      t.decimal :longitude
      t.string :world_region
      t.string :country
      t.string :decommissioned
      t.integer :estimated_population
      t.text :notes

      t.timestamps
    end
  end
end
