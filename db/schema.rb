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

ActiveRecord::Schema.define(version: 20160305163342) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authors", ["name"], name: "index_authors_on_name"

  create_table "authors_books", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authors_books", ["author_id"], name: "index_authors_books_on_author_id"
  add_index "authors_books", ["book_id"], name: "index_authors_books_on_book_id"

  create_table "books", force: :cascade do |t|
    t.integer  "publisher_id"
    t.string   "isbn10"
    t.string   "isbn13"
    t.datetime "date_added"
    t.text     "raw_barcode"
    t.string   "google_volume_id"
    t.text     "google_volume_raw_data"
    t.string   "title"
    t.string   "subtitle"
    t.date     "published_date"
    t.text     "description"
    t.integer  "page_count"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "published_year"
    t.integer  "published_month"
    t.integer  "published_day"
  end

  add_index "books", ["date_added"], name: "index_books_on_date_added"
  add_index "books", ["isbn10"], name: "index_books_on_isbn10"
  add_index "books", ["isbn13"], name: "index_books_on_isbn13"
  add_index "books", ["published_day"], name: "index_books_on_published_day"
  add_index "books", ["published_month"], name: "index_books_on_published_month"
  add_index "books", ["published_year"], name: "index_books_on_published_year"
  add_index "books", ["publisher_id"], name: "index_books_on_publisher_id"
  add_index "books", ["title"], name: "index_books_on_title"

  create_table "books_categories", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "books_categories", ["book_id"], name: "index_books_categories_on_book_id"
  add_index "books_categories", ["category_id"], name: "index_books_categories_on_category_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name"

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "publishers", ["name"], name: "index_publishers_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name"

end
