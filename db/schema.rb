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

ActiveRecord::Schema.define(version: 20140523002050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id",        null: false
    t.integer  "post_thread_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["post_thread_id"], name: "index_bookmarks_on_post_thread_id", using: :btree
  add_index "bookmarks", ["user_id", "post_thread_id"], name: "index_bookmarks_on_user_id_and_post_thread_id", unique: true, using: :btree
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "forums", force: true do |t|
    t.string   "name",       null: false
    t.integer  "rank",       null: false
    t.integer  "section_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["section_id"], name: "index_forums_on_section_id", using: :btree

  create_table "post_threads", force: true do |t|
    t.string   "title",      null: false
    t.integer  "user_id",    null: false
    t.integer  "forum_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_threads", ["forum_id"], name: "index_post_threads_on_forum_id", using: :btree
  add_index "post_threads", ["user_id"], name: "index_post_threads_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.text     "body",                        null: false
    t.integer  "user_id"
    t.integer  "post_thread_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "edited",         default: ""
  end

  add_index "posts", ["post_thread_id"], name: "index_posts_on_post_thread_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "sections", force: true do |t|
    t.string   "name",       null: false
    t.integer  "rank",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["name"], name: "index_sections_on_name", unique: true, using: :btree
  add_index "sections", ["rank"], name: "index_sections_on_rank", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                                       null: false
    t.string   "email",                                          null: false
    t.string   "session_token",                                  null: false
    t.string   "password_digest",                                null: false
    t.string   "role",            default: "USER",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",          default: "default_avatar.png"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
