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

ActiveRecord::Schema.define(version: 20150819024132) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "favourited_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_histories", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "last_reproduction"
    t.integer  "visits_count"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "surname"
    t.integer  "failed_login_count"
    t.datetime "disabled_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "mail_1"
    t.string   "mail_2"
    t.string   "mail_3"
    t.string   "cel_1"
    t.string   "cel_2"
    t.date     "birthday"
    t.string   "country"
    t.string   "gender"
    t.string   "password_digest"
    t.string   "facebook_id"
  end

  create_table "users_videos", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.string   "url_preview"
    t.datetime "uploaded_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

end
