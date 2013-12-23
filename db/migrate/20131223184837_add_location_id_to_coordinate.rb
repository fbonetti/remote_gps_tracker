class AddLocationIdToCoordinate < ActiveRecord::Migration
  def change
    add_column :coordinates, :location_id, :integer
  end
end
