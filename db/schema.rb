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

ActiveRecord::Schema.define(version: 20180207202404) do

  create_table "acquisition_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "authors_books", force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_authors_books_on_author_id"
    t.index ["book_id"], name: "index_authors_books_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "publisher_id"
    t.string "isbn10"
    t.string "isbn13"
    t.datetime "date_added"
    t.text "raw_barcode"
    t.string "google_volume_id"
    t.text "google_volume_raw_data"
    t.string "title"
    t.string "subtitle"
    t.date "published_date"
    t.text "description"
    t.integer "page_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "published_year"
    t.integer "published_month"
    t.integer "published_day"
    t.boolean "in_library", default: false, null: false
    t.integer "media_type_id"
    t.integer "source_id"
    t.integer "recipient_id"
    t.integer "acquisition_type_id"
    t.index ["acquisition_type_id"], name: "index_books_on_acquisition_type_id"
    t.index ["date_added"], name: "index_books_on_date_added"
    t.index ["isbn10"], name: "index_books_on_isbn10"
    t.index ["isbn13"], name: "index_books_on_isbn13"
    t.index ["media_type_id"], name: "index_books_on_media_type_id"
    t.index ["published_day"], name: "index_books_on_published_day"
    t.index ["published_month"], name: "index_books_on_published_month"
    t.index ["published_year"], name: "index_books_on_published_year"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["recipient_id"], name: "index_books_on_recipient_id"
    t.index ["source_id"], name: "index_books_on_source_id"
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "media_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_publishers_on_name"
  end

  create_table "system_configs", force: :cascade do |t|
    t.string "library_name"
    t.boolean "public_book_display", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "transacting_entities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_transacting_entities_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "active", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

end
