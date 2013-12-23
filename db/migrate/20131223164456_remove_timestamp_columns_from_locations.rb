class RemoveTimestampColumnsFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :created_at
    remove_column :locations, :updated_at
  end
end
