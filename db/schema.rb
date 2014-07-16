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

ActiveRecord::Schema.define(version: 20140716180545) do

  create_table "fish_dates", force: true do |t|
    t.date     "day"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fish_dates", ["season_id"], name: "index_fish_dates_on_season_id"

  create_table "properties", force: true do |t|
    t.integer  "current_season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: true do |t|
    t.integer  "year"
    t.integer  "start_month"
    t.integer  "end_month"
    t.integer  "slot_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slots", force: true do |t|
    t.integer  "fish_date_id"
    t.integer  "user_id"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slots", ["fish_date_id"], name: "index_slots_on_fish_date_id"
  add_index "slots", ["user_id"], name: "index_slots_on_user_id"

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.integer  "purchased"
    t.text     "guests"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
  end

  add_index "users", ["season_id"], name: "index_users_on_season_id"

end
