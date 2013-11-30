class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.datetime :timestamp

      t.timestamps
    end
  end
end
