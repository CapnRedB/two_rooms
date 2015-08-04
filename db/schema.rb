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

ActiveRecord::Schema.define(version: 20150804151409) do

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

  create_table "deck_cards", force: :cascade do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.string   "affiliation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "decks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "bury"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "game_logs", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "event"
    t.string   "command"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "game_players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "card_id"
    t.string   "location"
    t.boolean  "leader"
    t.integer  "voting_for_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "game_swaps", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "round_id"
    t.integer  "sequence"
    t.integer  "a_to_b_id"
    t.integer  "b_to_a_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "deck_id"
    t.string   "game_type"
    t.string   "status"
    t.text     "outcome"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
end
