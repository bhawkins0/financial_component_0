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

ActiveRecord::Schema.define(version: 2021_08_26_131305) do

  create_table "financial_component_accounts", force: :cascade do |t|
    t.string "fc_statement"
    t.integer "fc_account_number"
    t.string "fc_account_group"
    t.string "fc_account_reporting_group"
    t.boolean "fc_account_type"
    t.string "fc_account_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "financial_component_keywords", force: :cascade do |t|
    t.string "plaid_name"
    t.string "plaid_merchant_name"
    t.string "plaid_category"
    t.integer "fc_split_id"
    t.integer "transaction_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fc_debit"
    t.integer "fc_credit"
  end

  create_table "financial_component_transaction_split_templates", force: :cascade do |t|
    t.string "fc_transaction_split_template_name"
    t.float "fc_transaction_split_percent"
    t.integer "fc_account_number"
    t.boolean "fc_transaction_split_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "financial_component_transaction_splits", force: :cascade do |t|
    t.string "plaid_transaction_id"
    t.integer "fc_account_number"
    t.integer "fc_transaction_split_template_id"
    t.float "fc_amount"
    t.boolean "fc_transaction_split_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "financial_component_transactions", force: :cascade do |t|
    t.string "plaid_transaction_id"
    t.float "fc_amount"
    t.integer "fc_account_number"
    t.boolean "fc_transaction_type"
    t.boolean "fc_commit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fc_transaction_id"
  end

  create_table "plaid_accounts", force: :cascade do |t|
    t.string "plaid_institution_id"
    t.string "plaid_account_id"
    t.string "plaid_account_name"
    t.string "plaid_account_type"
    t.string "fc_account_normal_balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "fc_user_id"
  end

  create_table "plaid_institutions", force: :cascade do |t|
    t.string "plaid_institution_id"
    t.string "plaid_name"
    t.text "plaid_logo"
    t.integer "fc_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plaid_transactions", force: :cascade do |t|
    t.string "plaid_account_id"
    t.date "plaid_authorized_date"
    t.date "plaid_date"
    t.string "plaid_name"
    t.float "plaid_amount"
    t.string "plaid_iso_currency_code"
    t.string "plaid_category"
    t.string "plaid_merchant_name"
    t.string "plaid_address"
    t.string "plaid_city"
    t.string "plaid_region"
    t.string "plaid_postal_code"
    t.string "plaid_country"
    t.float "plaid_latitude"
    t.float "plaid_longitude"
    t.string "plaid_transaction_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "mobile"
    t.datetime "mobile_verified_at"
  end

end
