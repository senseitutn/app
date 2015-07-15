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

ActiveRecord::Schema.define(version: 20150714034510) do

  create_table "consumer_videos", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "consumer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "consumers", force: :cascade do |t|
    t.string   "token_fb"
    t.string   "image_url"
    t.string   "mail_1"
    t.string   "mail_2"
    t.string   "mail_3"
    t.string   "cel_1"
    t.string   "cel_2"
    t.date     "birthday"
    t.string   "country"
    t.string   "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "consumer_id"
    t.datetime "favourited_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_histories", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "consumer_id"
    t.datetime "last_reproduction"
    t.integer  "visits_count"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.string   "url_preview"
    t.datetime "uploaded_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
