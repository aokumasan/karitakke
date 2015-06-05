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

ActiveRecord::Schema.define(version: 20150525145127) do

  create_table "book_rental_infos", force: :cascade do |t|
    t.integer  "rental_count"
    t.integer  "last_rental_id"
    t.string   "last_rental_name"
    t.integer  "now_rental_id"
    t.string   "now_rental_name"
    t.integer  "Book_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "book_rental_infos", ["Book_id"], name: "index_book_rental_infos_on_Book_id"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "manufacturer"
    t.date     "publication_date"
    t.string   "isbn"
    t.string   "code"
    t.string   "limage"
    t.string   "simage"
    t.integer  "Rental_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "books", ["Rental_id"], name: "index_books_on_Rental_id"

  create_table "rentals", force: :cascade do |t|
    t.datetime "rental_date"
    t.datetime "return_date"
    t.string   "user_name"
    t.integer  "User_id"
    t.integer  "Book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rentals", ["Book_id"], name: "index_rentals_on_Book_id"
  add_index "rentals", ["User_id"], name: "index_rentals_on_User_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "member"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
