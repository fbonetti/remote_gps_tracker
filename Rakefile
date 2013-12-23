# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'csv'

RemoteGpsTracker::Application.load_tasks

task "db:import_zip_codes" => "environment" do
  Location.delete_all

  sh "curl http://www.unitedstateszipcodes.org/zip_code_database.csv -o ~/Downloads/zip_code_database.csv"
  ActiveRecord::Base.connection.execute("
    COPY locations (zip, type, primary_city, acceptable_cities, unacceptable_cities, state, county, timezone, area_codes, latitude, longitude, world_region, country, decommissioned, estimated_population, notes)
    FROM '/home/frankbonetti/Downloads/zip_code_database.csv'
    CSV HEADER;
  ")
end