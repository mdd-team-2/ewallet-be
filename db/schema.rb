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

ActiveRecord::Schema.define(version: 2019_05_05_034202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mddtransactions", force: :cascade do |t|
    t.integer "target_id"
    t.bigint "wallet_id"
    t.bigint "transaction_type_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ingress"
    t.index ["transaction_type_id"], name: "index_mddtransactions_on_transaction_type_id"
    t.index ["wallet_id"], name: "index_mddtransactions_on_wallet_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "mddtransaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mddtransaction_id"], name: "index_payments_on_mddtransaction_id"
    t.index ["service_id"], name: "index_payments_on_service_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.datetime "activation_date"
    t.datetime "last_activity_date"
    t.float "maximum_value"
    t.float "current_value"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "mddtransactions", "transaction_types"
  add_foreign_key "mddtransactions", "wallets"
  add_foreign_key "payments", "mddtransactions"
  add_foreign_key "payments", "services"
  add_foreign_key "users", "roles"
  add_foreign_key "wallets", "users"
end
