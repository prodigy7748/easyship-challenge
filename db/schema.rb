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

ActiveRecord::Schema.define(version: 2021_03_05_141310) do

  create_table "companies", id: :string, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipment_items", force: :cascade do |t|
    t.string "description"
    t.integer "shipment_id"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipment_id"], name: "index_shipment_items_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "destination_country"
    t.string "origin_country"
    t.string "tracking_number"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_id", null: false
    t.index ["company_id"], name: "index_shipments_on_company_id"
  end

  add_foreign_key "shipment_items", "shipments"
  add_foreign_key "shipments", "companies"
end
