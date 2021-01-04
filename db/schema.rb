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

ActiveRecord::Schema.define(version: 2020_12_29_035056) do

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "gender", null: false
    t.integer "age", null: false
    t.boolean "married", default: false
    t.integer "children", default: 0
    t.string "family_type"
    t.decimal "family_average_income", default: "0.0"
    t.string "bio"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "expenses", force: :cascade do |t|
    t.string "spent_on"
    t.decimal "amount"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id", default: 0, null: false
    t.index ["group_id"], name: "index_expenses_on_group_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "incomes", force: :cascade do |t|
    t.string "source"
    t.decimal "amount"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id", default: 0, null: false
    t.index ["group_id"], name: "index_incomes_on_group_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "loans", force: :cascade do |t|
    t.string "loan_from"
    t.decimal "amount"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id", default: 0, null: false
    t.index ["group_id"], name: "index_loans_on_group_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.boolean "confirmed"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name", null: false
    t.string "gender", null: false
    t.integer "age", null: false
    t.boolean "married", default: false
    t.integer "children", default: 0
    t.string "family_type", default: "single"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bio"
    t.decimal "family_average_income", default: "0.0"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "savings", force: :cascade do |t|
    t.string "saved_on"
    t.decimal "amount"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "group_id", default: 0, null: false
    t.index ["group_id"], name: "index_savings_on_group_id"
    t.index ["user_id"], name: "index_savings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "expenses", "groups"
  add_foreign_key "expenses", "users"
  add_foreign_key "incomes", "groups"
  add_foreign_key "incomes", "users"
  add_foreign_key "loans", "groups"
  add_foreign_key "loans", "users"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "savings", "groups"
  add_foreign_key "savings", "users"
end
