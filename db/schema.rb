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

ActiveRecord::Schema[7.0].define(version: 2023_10_17_091254) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stamp_rally_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stamp_rally_id"], name: "index_participants_on_stamp_rally_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "participants_stamps", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "stamp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_participants_stamps_on_participant_id"
    t.index ["stamp_id"], name: "index_participants_stamps_on_stamp_id"
  end

  create_table "sns_credentials", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "stamp_rallies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "image"
    t.integer "visibility", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stamp_rallies_on_user_id"
  end

  create_table "stamp_rally_tags", force: :cascade do |t|
    t.bigint "stamp_rally_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stamp_rally_id"], name: "index_stamp_rally_tags_on_stamp_rally_id"
    t.index ["tag_id"], name: "index_stamp_rally_tags_on_tag_id"
  end

  create_table "stamps", force: :cascade do |t|
    t.bigint "stamp_rally_id", null: false
    t.string "name", null: false
    t.string "sticker", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stamp_rally_id"], name: "index_stamps_on_stamp_rally_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "participants", "stamp_rallies"
  add_foreign_key "participants", "users"
  add_foreign_key "participants_stamps", "participants"
  add_foreign_key "participants_stamps", "stamps"
  add_foreign_key "sns_credentials", "users"
  add_foreign_key "stamp_rallies", "users"
  add_foreign_key "stamp_rally_tags", "stamp_rallies"
  add_foreign_key "stamp_rally_tags", "tags"
  add_foreign_key "stamps", "stamp_rallies"
end
