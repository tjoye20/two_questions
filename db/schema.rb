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

ActiveRecord::Schema.define(version: 2019_06_06_010158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.integer "recipient_id", null: false
    t.string "uuid", null: false
    t.string "state", default: "new", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
    t.index ["uuid"], name: "index_conversations_on_uuid"
  end

  create_table "messages", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["uuid"], name: "index_messages_on_uuid"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "user_id", null: false
    t.integer "gender", null: false
    t.integer "gender_seeking", null: false
    t.text "bio", null: false
    t.integer "race", null: false
    t.integer "looking_for", null: false
    t.string "location", null: false
    t.string "images", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
    t.index ["uuid"], name: "index_profiles_on_uuid"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "body", null: false
    t.string "state", default: "active", null: false
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_questions_on_profile_id"
    t.index ["uuid"], name: "index_questions_on_uuid"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.string "uuid", null: false
    t.string "state", default: "new", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_requests_on_profile_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
    t.index ["uuid"], name: "index_requests_on_uuid"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.text "body", null: false
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
    t.index ["uuid"], name: "index_responses_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "email", null: false
    t.text "image"
    t.string "display_name"
    t.string "state", default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  create_table "views", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "user_id", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_views_on_profile_id"
    t.index ["user_id"], name: "index_views_on_user_id"
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "profiles"
  add_foreign_key "requests", "profiles"
  add_foreign_key "requests", "users"
  add_foreign_key "responses", "questions"
  add_foreign_key "responses", "users"
  add_foreign_key "views", "profiles"
  add_foreign_key "views", "users"
end
