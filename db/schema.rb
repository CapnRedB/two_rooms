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

ActiveRecord::Schema.define(version: 20150226215949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_relationships", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "to_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "short_desc"
    t.text     "long_desc"
    t.string   "color"
    t.string   "faction"
    t.text     "strategy"
    t.string   "url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "sort_order"
    t.integer  "quantity",         default: 1
    t.text     "required_text"
    t.text     "recommended_text"
  end

  create_table "rounds", force: :cascade do |t|
    t.string   "game_type"
    t.integer  "number"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swaps", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "player_min"
    t.integer  "player_max"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
