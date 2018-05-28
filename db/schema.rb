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

ActiveRecord::Schema.define(version: 2018_05_28_093943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hunt_transactions", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id"
    t.string "eth_address", limit: 42
    t.string "eth_tx_hash", limit: 66
    t.decimal "amount", null: false
    t.string "memo"
    t.datetime "created_at", default: "2018-05-20 15:00:00", null: false
    t.index ["receiver_id"], name: "index_hunt_transactions_on_receiver_id"
    t.index ["sender_id"], name: "index_hunt_transactions_on_sender_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "author", null: false
    t.string "url", null: false
    t.string "title", null: false
    t.string "tagline", null: false
    t.string "tags", default: [], array: true
    t.json "images"
    t.json "beneficiaries"
    t.string "permlink"
    t.boolean "is_active", default: true
    t.float "payout_value", default: 0.0
    t.json "active_votes", default: []
    t.integer "children", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "is_verified", default: false
    t.string "verified_by"
    t.index "((((to_tsvector('english'::regconfig, (author)::text) || to_tsvector('english'::regconfig, (title)::text)) || to_tsvector('english'::regconfig, (tagline)::text)) || to_tsvector('english'::regconfig, immutable_array_to_string(tags, ' '::text))))", name: "index_posts_full_text", using: :gin
    t.index ["author", "permlink"], name: "index_posts_on_author_and_permlink", unique: true
    t.index ["created_at"], name: "index_posts_on_created_at"
    t.index ["is_active", "payout_value"], name: "index_posts_on_is_active_and_payout_value"
    t.index ["url"], name: "index_posts_on_url", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "encrypted_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_count", default: 0
    t.decimal "hunt_balance", default: "0.0"
    t.string "eth_address", limit: 42
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
