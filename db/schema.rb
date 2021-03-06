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

ActiveRecord::Schema.define(version: 2021_04_08_123637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "train_station"
    t.jsonb "session_times", default: {"friday"=>[], "monday"=>[], "sunday"=>[], "tuesday"=>[], "saturday"=>[], "thursday"=>[], "wednesday"=>[]}
    t.bigint "gm_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "rulebook_id", null: false
    t.index ["gm_id"], name: "index_groups_on_gm_id"
    t.index ["rulebook_id"], name: "index_groups_on_rulebook_id"
  end

  create_table "pairings", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "rulebook_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_pairings_on_genre_id"
    t.index ["rulebook_id"], name: "index_pairings_on_rulebook_id"
  end

  create_table "player_groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_player_groups_on_group_id"
    t.index ["user_id"], name: "index_player_groups_on_user_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_preferences_on_genre_id"
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "rulebooks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "img_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.jsonb "availability", default: {"friday"=>[], "monday"=>[], "sunday"=>[], "tuesday"=>[], "saturday"=>[], "thursday"=>[], "wednesday"=>[]}
    t.string "city"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "groups", "rulebooks"
  add_foreign_key "groups", "users", column: "gm_id"
  add_foreign_key "pairings", "genres"
  add_foreign_key "pairings", "rulebooks"
  add_foreign_key "player_groups", "groups"
  add_foreign_key "player_groups", "users"
  add_foreign_key "preferences", "genres"
  add_foreign_key "preferences", "users"
end
