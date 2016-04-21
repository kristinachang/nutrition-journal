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

ActiveRecord::Schema.define(version: 20160419083457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dailies", force: :cascade do |t|
    t.date     "date"
    t.datetime "date_eaten"
    t.integer  "mood"
    t.string   "notes"
    t.integer  "morning_total"
    t.integer  "midday_total"
    t.integer  "evening_total"
    t.integer  "day_total"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "dailies_items", id: false, force: :cascade do |t|
    t.integer "daily_id", null: false
    t.integer "item_id",  null: false
  end

  add_index "dailies_items", ["daily_id", "item_id"], name: "index_dailies_items_on_daily_id_and_item_id", using: :btree
  add_index "dailies_items", ["item_id", "daily_id"], name: "index_dailies_items_on_item_id_and_daily_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.date     "date"
    t.time     "time"
    t.datetime "time_eaten"
    t.string   "name"
    t.string   "ndbno"
    t.string   "protein"
    t.string   "fat"
    t.string   "carb"
    t.string   "kcal"
    t.string   "unit"
    t.integer  "mood"
    t.string   "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.integer  "height"
    t.integer  "weight"
    t.string   "activity_level"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end