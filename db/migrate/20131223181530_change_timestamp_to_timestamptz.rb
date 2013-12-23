class ChangeTimestampToTimestamptz < ActiveRecord::Migration
  def change
    rename_column :coordinates, :timestamp, :gps_timestamp
    change_column :coordinates, :gps_timestamp, :timestamptz
    remove_column :coordinates, :timezone
  end
end
