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

ActiveRecord::Schema.define(version: 2018_11_02_200921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "spotify_id"
  end

  create_table "spotify_user_artists", force: :cascade do |t|
    t.bigint "spotify_user_id"
    t.bigint "artist_id"
    t.string "time_duration"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_spotify_user_artists_on_artist_id"
    t.index ["spotify_user_id"], name: "index_spotify_user_artists_on_spotify_user_id"
  end

  create_table "spotify_users", force: :cascade do |t|
    t.string "spotify_id"
    t.string "display_name"
    t.string "email"
    t.boolean "has_paid_spotify"
    t.date "birthday"
    t.string "country"
    t.integer "followers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "artist_id"
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
  end

  create_table "venue_spotify_users", force: :cascade do |t|
    t.bigint "venue_id"
    t.bigint "spotify_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_user_id"], name: "index_venue_spotify_users_on_spotify_user_id"
    t.index ["venue_id"], name: "index_venue_spotify_users_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
