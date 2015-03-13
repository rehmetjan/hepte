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

ActiveRecord::Schema.define(version: 20150313051054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "name"
    t.string   "author"
    t.string   "picture"
    t.decimal  "price"
    t.string   "isbn"
    t.text     "description"
    t.decimal  "rate"
    t.float    "hot",            default: 0.0
    t.integer  "comments_count", default: 0
    t.integer  "likes_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree
  add_index "books", ["hot"], name: "index_books_on_hot", using: :btree
  add_index "books", ["user_id"], name: "index_books_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "books_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.integer  "likes_count",      default: 0
    t.boolean  "trashed",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.string   "password_digest"
    t.string   "avatar"
    t.text     "bio"
    t.boolean  "confirmed",       default: false
    t.string   "locale"
    t.string   "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
