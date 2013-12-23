# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131223184837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coordinates", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.datetime "gps_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "locations", force: true do |t|
    t.text    "zip"
    t.text    "type"
    t.text    "primary_city"
    t.text    "acceptable_cities"
    t.text    "unacceptable_cities"
    t.text    "state"
    t.text    "county"
    t.text    "timezone"
    t.text    "area_codes"
    t.decimal "latitude"
    t.decimal "longitude"
    t.text    "world_region"
    t.text    "country"
    t.text    "decommissioned"
    t.integer "estimated_population"
    t.text    "notes"
  end

  add_index "locations", ["latitude"], name: "index_locations_on_latitude", using: :btree
  add_index "locations", ["longitude"], name: "index_locations_on_longitude", using: :btree

end
