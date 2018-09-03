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

ActiveRecord::Schema.define(version: 2018_09_03_093326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ledgers", id: :serial, force: :cascade do |t|
    t.string "external_id"
    t.integer "sequence", null: false
    t.jsonb "body", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_ledgers_on_external_id"
    t.index ["sequence"], name: "index_ledgers_on_sequence", unique: true
  end

  create_table "operations", id: :serial, force: :cascade do |t|
    t.string "external_id", null: false
    t.jsonb "body", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "txn_external_id", null: false
    t.index "((body ->> 'asset_issuer'::text))", name: "operations_asset_issuer"
    t.index "((body ->> 'buying_asset_issuer'::text))", name: "operations_buying_asset_issuer"
    t.index "((body ->> 'from'::text))", name: "operations_from"
    t.index "((body ->> 'funder'::text))", name: "operations_funder"
    t.index "((body ->> 'into'::text))", name: "operations_into"
    t.index "((body ->> 'selling_asset_issuer'::text))", name: "operations_selling_asset_issuer"
    t.index "((body ->> 'send_asset_issuer'::text))", name: "operations_send_asset_issuer"
    t.index "((body ->> 'source_account'::text))", name: "operations_source_account"
    t.index "((body ->> 'to'::text))", name: "operations_to"
    t.index "((body ->> 'trustee'::text))", name: "operations_trustee"
    t.index "((body ->> 'trustor'::text))", name: "operations_trustor"
    t.index ["external_id"], name: "index_operations_on_external_id", unique: true
  end

  create_table "txns", id: :serial, force: :cascade do |t|
    t.string "external_id", null: false
    t.integer "ledger_sequence", null: false
    t.jsonb "body"
    t.index ["external_id"], name: "index_txns_on_external_id", unique: true
    t.index ["ledger_sequence"], name: "index_txns_on_ledger_sequence"
  end

  create_table "wards", id: :serial, force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "operations", "txns", column: "txn_external_id", primary_key: "external_id"
end
