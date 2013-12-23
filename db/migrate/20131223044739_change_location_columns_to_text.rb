class ChangeLocationColumnsToText < ActiveRecord::Migration
  def change
    change_column :locations, :zip, :text
    change_column :locations, :type, :text
    change_column :locations, :primary_city, :text
    change_column :locations, :acceptable_cities, :text
    change_column :locations, :unacceptable_cities, :text
    change_column :locations, :state, :text
    change_column :locations, :county, :text
    change_column :locations, :timezone, :text
    change_column :locations, :area_codes, :text
    change_column :locations, :world_region, :text
    change_column :locations, :country, :text
    change_column :locations, :decommissioned, :text
  end
end
