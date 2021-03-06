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

ActiveRecord::Schema.define(version: 20140406115114) do

  create_table "item_comments", force: true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_histories", force: true do |t|
    t.integer  "item_id"
    t.integer  "revision"
    t.string   "title"
    t.text     "content"
    t.string   "title_diff"
    t.text     "content_diff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_histories", ["item_id", "revision"], name: "index_item_histories_on_item_id_and_revision", unique: true

  create_table "items", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "items", ["user_id", "created_at"], name: "index_items_on_user_id_and_created_at"

  create_table "stars", force: true do |t|
    t.integer  "user_id"
    t.string   "site_id"
    t.string   "item_id"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.string   "title"
    t.string   "author"
  end

  add_index "stars", ["site_id", "item_id", "user_id"], name: "index_stars_on_site_id_and_item_id_and_user_id", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
