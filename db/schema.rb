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

ActiveRecord::Schema.define(version: 20160825072410) do

  create_table "banks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "type",                            limit: 255
    t.string   "application_number",              limit: 255
    t.integer  "id_number_type",                  limit: 4
    t.string   "id_number",                       limit: 255
    t.string   "name",                            limit: 255
    t.datetime "traded_at"
    t.integer  "person_in_charge_id_number_type", limit: 4
    t.string   "person_in_charge_id_number",      limit: 255
    t.string   "person_in_charge_name",           limit: 255
    t.string   "fund_trading_account_number",     limit: 255
    t.string   "sales_man_code",                  limit: 255
    t.string   "business_code",                   limit: 255
    t.string   "branch_store_number",             limit: 255
    t.string   "fund_account_number",             limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "status",                          limit: 255
  end

  create_table "consultants", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "department_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "consultants", ["department_id"], name: "index_consultants_on_department_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "departments", ["name"], name: "index_departments_on_name", unique: true, using: :btree

  create_table "product_managers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                                       limit: 255
    t.string   "client_code",                                limit: 255
    t.string   "short_name",                                 limit: 255
    t.string   "code",                                       limit: 255
    t.integer  "running_status",                             limit: 4
    t.string   "type",                                       limit: 255
    t.string   "dev_type",                                   limit: 255
    t.decimal  "initial_fund",                                           precision: 10
    t.string   "valuation_out_sourcing",                     limit: 255
    t.datetime "deposited_at"
    t.datetime "delegation_started_at"
    t.datetime "delegation_ended_at"
    t.decimal  "delegation_duration",                                    precision: 10
    t.string   "fee_calculation_standard",                   limit: 255
    t.decimal  "management_fee_ratio",                                   precision: 10
    t.string   "year_day_count",                             limit: 255
    t.decimal  "management_fee_flour",                                   precision: 10
    t.decimal  "trustor_fee_ratio",                                      precision: 10
    t.decimal  "operation_fee_ratio",                                    precision: 10
    t.decimal  "investment_consultant_fee_ratio",                        precision: 10
    t.decimal  "investment_consultant_fee_flour",                        precision: 10
    t.string   "bonus",                                      limit: 255
    t.decimal  "sales_fee_ratio",                                        precision: 10
    t.string   "sse_account_code",                           limit: 255
    t.string   "szse_account_code",                          limit: 255
    t.string   "cffex_account_code",                         limit: 255
    t.string   "zce_account_code",                           limit: 255
    t.string   "dce_account_code",                           limit: 255
    t.string   "shfe_account_code",                          limit: 255
    t.string   "sales_department",                           limit: 255
    t.string   "investment_consultant_reference_department", limit: 255
    t.string   "operation_department",                       limit: 255
    t.string   "investment_consultant_name",                 limit: 255
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "sse_gateway",                                limit: 255
    t.string   "szse_gateway",                               limit: 255
    t.integer  "product_manager_id",                         limit: 4
    t.integer  "trustor_id",                                 limit: 4
    t.integer  "securities_broker_id",                       limit: 4
  end

  add_index "products", ["product_manager_id"], name: "index_products_on_product_manager_id", using: :btree
  add_index "products", ["securities_broker_id"], name: "index_products_on_securities_broker_id", using: :btree
  add_index "products", ["trustor_id"], name: "index_products_on_trustor_id", using: :btree

  create_table "securities_brokers", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "bank_id",        limit: 4
    t.string   "account_number", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "securities_brokers", ["bank_id"], name: "index_securities_brokers_on_bank_id", using: :btree

  create_table "trustors", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "bank_id",        limit: 4
    t.string   "account_name",   limit: 255
    t.string   "account_number", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "trustors", ["bank_id"], name: "index_trustors_on_bank_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
    t.string   "full_name",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "consultants", "departments"
  add_foreign_key "products", "product_managers"
  add_foreign_key "products", "securities_brokers"
  add_foreign_key "products", "trustors"
  add_foreign_key "securities_brokers", "banks"
  add_foreign_key "trustors", "banks"
end
