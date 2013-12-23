class AddTimezoneToCoordinates < ActiveRecord::Migration
  def change
    add_column :coordinates, :timezone, :string
  end
end
