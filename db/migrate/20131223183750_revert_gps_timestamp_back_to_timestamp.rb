class RevertGpsTimestampBackToTimestamp < ActiveRecord::Migration
  def change
    change_column :coordinates, :gps_timestamp, :datetime
  end
end
