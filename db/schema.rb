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

ActiveRecord::Schema.define(version: 20160917035656) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "assignments", ["role_id"], name: "index_assignments_on_role_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

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
    t.string   "name",                               limit: 255
    t.integer  "department_id",                      limit: 4
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "capital",                            limit: 255
    t.integer  "institution_type",                   limit: 4
    t.string   "person_in_charge_name",              limit: 255
    t.boolean  "is_qualified_3rd_party_institution",             default: true
    t.string   "company_address",                    limit: 255
    t.string   "short_name",                         limit: 255
  end

  add_index "consultants", ["department_id"], name: "index_consultants_on_department_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "departments", ["name"], name: "index_departments_on_name", unique: true, using: :btree

  create_table "money_records", force: :cascade do |t|
    t.datetime "done_at"
    t.string   "type",       limit: 255
    t.decimal  "amount",                 precision: 10
    t.integer  "staff_id",   limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "money_records", ["product_id"], name: "index_money_records_on_product_id", using: :btree
  add_index "money_records", ["staff_id"], name: "index_money_records_on_staff_id", using: :btree

  create_table "product_managers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "product_managers", ["user_id"], name: "index_product_managers_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "client_code",                  limit: 255
    t.string   "short_name",                   limit: 255
    t.string   "code",                         limit: 255
    t.integer  "status",                       limit: 4,   default: 0
    t.integer  "category",                     limit: 4
    t.integer  "rd_category",                  limit: 4
    t.string   "initial_fund",                 limit: 255
    t.string   "valuation_out_sourcing",       limit: 255
    t.datetime "deposited_at"
    t.datetime "delegation_started_at"
    t.datetime "delegation_ended_at"
    t.string   "delegation_duration",          limit: 255
    t.string   "fee_calculation_standard",     limit: 255
    t.string   "management_fee_ratio",         limit: 255
    t.string   "year_day_count",               limit: 255
    t.string   "management_fee_flour",         limit: 255
    t.string   "trustor_fee_ratio",            limit: 255
    t.string   "operation_fee_ratio",          limit: 255
    t.string   "consultant_fee_ratio",         limit: 255
    t.string   "consultant_fee_flour",         limit: 255
    t.string   "bonus",                        limit: 255
    t.string   "sales_fee_ratio",              limit: 255
    t.string   "sse_account_code",             limit: 255
    t.string   "szse_account_code",            limit: 255
    t.string   "cffex_account_code",           limit: 255
    t.string   "zce_account_code",             limit: 255
    t.string   "dce_account_code",             limit: 255
    t.string   "shfe_account_code",            limit: 255
    t.string   "consultant_name",              limit: 255
    t.string   "sse_gateway",                  limit: 255
    t.string   "szse_gateway",                 limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "trustor_bank_account_id",      limit: 4
    t.integer  "securities_broker_account_id", limit: 4
    t.integer  "sales_department_id",          limit: 4
    t.integer  "operation_department_id",      limit: 4
    t.integer  "consultant_id",                limit: 4
    t.integer  "staff_id",                     limit: 4
    t.boolean  "is_structured",                            default: false
    t.string   "superior_code",                limit: 255
    t.string   "inferior_code",                limit: 255
    t.boolean  "is_one_to_many",                           default: false
    t.string   "leverage",                     limit: 255
    t.datetime "put_on_record_at"
    t.datetime "liquidated_at"
    t.string   "cffex_gateway",                limit: 255
    t.string   "zce_gateway",                  limit: 255
    t.string   "dce_gateway",                  limit: 255
    t.string   "shfe_gateway",                 limit: 255
  end

  add_index "products", ["client_code"], name: "index_products_on_client_code", unique: true, using: :btree
  add_index "products", ["code"], name: "index_products_on_code", unique: true, using: :btree
  add_index "products", ["consultant_id"], name: "index_products_on_consultant_id", using: :btree
  add_index "products", ["inferior_code"], name: "index_products_on_inferior_code", unique: true, using: :btree
  add_index "products", ["name"], name: "index_products_on_name", unique: true, using: :btree
  add_index "products", ["operation_department_id"], name: "index_products_on_operation_department_id", using: :btree
  add_index "products", ["sales_department_id"], name: "index_products_on_sales_department_id", using: :btree
  add_index "products", ["securities_broker_account_id"], name: "index_products_on_securities_broker_account_id", using: :btree
  add_index "products", ["short_name"], name: "index_products_on_short_name", unique: true, using: :btree
  add_index "products", ["staff_id"], name: "index_products_on_staff_id", using: :btree
  add_index "products", ["superior_code"], name: "index_products_on_superior_code", unique: true, using: :btree
  add_index "products", ["trustor_bank_account_id"], name: "index_products_on_trustor_bank_account_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "securities_broker_accounts", force: :cascade do |t|
    t.integer  "securities_broker_id", limit: 4
    t.string   "name",                 limit: 255
    t.string   "number",               limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "securities_broker_accounts", ["securities_broker_id"], name: "index_securities_broker_accounts_on_securities_broker_id", using: :btree

  create_table "securities_brokers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "department_id",         limit: 4
    t.string   "position",              limit: 255
    t.string   "duration",              limit: 255
    t.string   "office_tel",            limit: 255
    t.string   "mobile",                limit: 255
    t.text     "resume",                limit: 65535
    t.boolean  "is_investment_manager"
    t.string   "certification_id",      limit: 255
    t.integer  "user_id",               limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                 limit: 255
  end

  add_index "staffs", ["department_id"], name: "index_staffs_on_department_id", using: :btree
  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true, using: :btree
  add_index "staffs", ["user_id"], name: "index_staffs_on_user_id", using: :btree

  create_table "trustor_bank_accounts", force: :cascade do |t|
    t.integer  "trustor_id", limit: 4
    t.integer  "bank_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "number",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "trustor_bank_accounts", ["bank_id"], name: "index_trustor_bank_accounts_on_bank_id", using: :btree
  add_index "trustor_bank_accounts", ["trustor_id"], name: "index_trustor_bank_accounts_on_trustor_id", using: :btree

  create_table "trustors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
  add_foreign_key "consultants", "departments"
  add_foreign_key "money_records", "products"
  add_foreign_key "money_records", "staffs"
  add_foreign_key "product_managers", "users"
  add_foreign_key "products", "consultants"
  add_foreign_key "products", "departments", column: "operation_department_id"
  add_foreign_key "products", "departments", column: "sales_department_id"
  add_foreign_key "products", "securities_broker_accounts"
  add_foreign_key "products", "staffs"
  add_foreign_key "products", "trustor_bank_accounts"
  add_foreign_key "securities_broker_accounts", "securities_brokers"
  add_foreign_key "staffs", "departments"
  add_foreign_key "staffs", "users"
  add_foreign_key "trustor_bank_accounts", "banks"
  add_foreign_key "trustor_bank_accounts", "trustors"
end
