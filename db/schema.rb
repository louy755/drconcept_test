# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_26_165239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delivers", force: :cascade do |t|
    t.decimal "delivery", default: "0.0"
    t.decimal "fee", default: "0.0"
    t.decimal "discount", default: "0.0"
    t.date "delivery_date"
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_delivers_on_person_id"
  end

  create_table "goods", force: :cascade do |t|
    t.integer "qnt", default: 0
    t.string "item"
    t.decimal "price", default: "0.0"
    t.string "description"
    t.string "vendor"
    t.decimal "sub_total", default: "0.0"
    t.decimal "taxx", default: "0.0"
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_goods_on_person_id"
  end

  create_table "pays", force: :cascade do |t|
    t.decimal "amount", default: "0.0"
    t.string "method"
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_pays_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.decimal "subtotal", default: "0.0"
    t.decimal "tax", default: "0.0"
    t.decimal "total", default: "0.0"
    t.string "sale_rep"
    t.decimal "profit", default: "0.0"
    t.decimal "margin", default: "0.0"
    t.decimal "cost", default: "0.0"
    t.decimal "delivery", default: "0.0"
    t.decimal "fee", default: "0.0"
    t.decimal "discount", default: "0.0"
    t.boolean "finance", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "delivers", "people"
  add_foreign_key "goods", "people"
  add_foreign_key "pays", "people"
  add_foreign_key "people", "users"
end
