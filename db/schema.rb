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

ActiveRecord::Schema.define(version: 20170314071638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ledgers", force: :cascade do |t|
    t.string   "external_id"
    t.integer  "sequence",                 null: false
    t.jsonb    "body",        default: {}, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["external_id"], name: "index_ledgers_on_external_id", using: :btree
    t.index ["sequence"], name: "index_ledgers_on_sequence", unique: true, using: :btree
  end

  create_table "operations", force: :cascade do |t|
    t.string   "external_id",                  null: false
    t.jsonb    "body",            default: {}, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "txn_external_id",              null: false
    t.index "((body ->> 'asset_issuer'::text))", name: "operations_asset_issuer", using: :btree
    t.index "((body ->> 'buying_asset_issuer'::text))", name: "operations_buying_asset_issuer", using: :btree
    t.index "((body ->> 'from'::text))", name: "operations_from", using: :btree
    t.index "((body ->> 'funder'::text))", name: "operations_funder", using: :btree
    t.index "((body ->> 'into'::text))", name: "operations_into", using: :btree
    t.index "((body ->> 'selling_asset_issuer'::text))", name: "operations_selling_asset_issuer", using: :btree
    t.index "((body ->> 'send_asset_issuer'::text))", name: "operations_send_asset_issuer", using: :btree
    t.index "((body ->> 'source_account'::text))", name: "operations_source_account", using: :btree
    t.index "((body ->> 'to'::text))", name: "operations_to", using: :btree
    t.index "((body ->> 'trustee'::text))", name: "operations_trustee", using: :btree
    t.index "((body ->> 'trustor'::text))", name: "operations_trustor", using: :btree
    t.index ["external_id"], name: "index_operations_on_external_id", unique: true, using: :btree
  end

  create_table "report_responses", force: :cascade do |t|
    t.integer "report_id"
    t.text    "body"
    t.integer "status_code"
    t.index ["report_id"], name: "index_report_responses_on_report_id", using: :btree
    t.index ["status_code"], name: "index_report_responses_on_status_code", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "ward_id"
    t.integer  "operation_id"
    t.integer  "status",       default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["operation_id"], name: "index_reports_on_operation_id", using: :btree
    t.index ["ward_id", "operation_id"], name: "index_reports_on_ward_id_and_operation_id", unique: true, using: :btree
    t.index ["ward_id"], name: "index_reports_on_ward_id", using: :btree
  end

  create_table "txns", force: :cascade do |t|
    t.string  "external_id",     null: false
    t.integer "ledger_sequence", null: false
    t.jsonb   "body"
    t.index ["external_id"], name: "index_txns_on_external_id", unique: true, using: :btree
    t.index ["ledger_sequence"], name: "index_txns_on_ledger_sequence", using: :btree
  end

  create_table "wards", force: :cascade do |t|
    t.string   "address",      null: false
    t.string   "callback_url", null: false
    t.string   "secret",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["address", "callback_url"], name: "index_wards_on_address_and_callback_url", unique: true, using: :btree
  end

  add_foreign_key "operations", "txns", column: "txn_external_id", primary_key: "external_id"
  add_foreign_key "report_responses", "reports"
  add_foreign_key "reports", "operations"
  add_foreign_key "reports", "wards"
end
