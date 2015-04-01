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

ActiveRecord::Schema.define(version: 20150329174822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "steps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "refresh_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "days", force: true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "life_expectancy"
    t.integer  "life_gained_lost", default: 0
    t.integer  "total_lgl",        default: 0
  end

  add_index "days", ["activity_id"], name: "index_days_on_activity_id", using: :btree
  add_index "days", ["user_id"], name: "index_days_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "age"
    t.boolean  "gender"
    t.integer  "weight_kgs"
    t.decimal  "height_meters"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
