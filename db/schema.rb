# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_09_28_173012) do
  create_table "card_sets", id: { type: :binary, limit: 16 }, force: :cascade do |t|
    t.binary "player_id", limit: 16, null: false
    t.integer "round"
    t.integer "cards"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_card_sets_on_id", unique: true
    t.index ["player_id"], name: "index_card_sets_on_player_id"
    t.index ["round", "color", "player_id"], name: "index_card_sets_on_round_and_color_and_player_id", unique: true
  end

  create_table "games", id: { type: :binary, limit: 16 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "user_id", limit: 16
    t.index ["id"], name: "index_games_on_id", unique: true
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "players", id: { type: :binary, limit: 16 }, force: :cascade do |t|
    t.binary "game_id", limit: 16, null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["id"], name: "index_players_on_id", unique: true
  end

  create_table "sessions", id: { type: :binary, limit: 16 }, force: :cascade do |t|
    t.binary "user_id", limit: 16, null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_sessions_on_id", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", id: { type: :binary, limit: 16 }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id", unique: true
  end

  add_foreign_key "card_sets", "players"
  add_foreign_key "games", "users"
  add_foreign_key "players", "games"
  add_foreign_key "sessions", "users"
end
