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

ActiveRecord::Schema.define(version: 20160723174156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inbound_logs", force: :cascade do |t|
    t.integer  "inbound_order_id",              null: false
    t.integer  "product_id",                    null: false
    t.jsonb    "properties",       default: {}, null: false
    t.integer  "quantity",                      null: false
    t.integer  "shelf_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["inbound_order_id"], name: "index_inbound_logs_on_inbound_order_id", using: :btree
    t.index ["product_id"], name: "index_inbound_logs_on_product_id", using: :btree
    t.index ["shelf_id"], name: "index_inbound_logs_on_shelf_id", using: :btree
  end

  create_table "inbound_order_transitions", force: :cascade do |t|
    t.string   "to_state",                      null: false
    t.jsonb    "metadata",         default: {}
    t.integer  "sort_key",                      null: false
    t.integer  "inbound_order_id",              null: false
    t.boolean  "most_recent",                   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["inbound_order_id", "most_recent"], name: "index_inbound_order_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
    t.index ["inbound_order_id", "sort_key"], name: "index_inbound_order_transitions_parent_sort", unique: true, using: :btree
  end

  create_table "inbound_orders", force: :cascade do |t|
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "inbound_log_id",                 null: false
    t.integer  "product_id",                     null: false
    t.jsonb    "properties",      default: "{}", null: false
    t.integer  "shelf_id"
    t.integer  "rank"
    t.integer  "outbound_log_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["inbound_log_id"], name: "index_items_on_inbound_log_id", using: :btree
    t.index ["outbound_log_id"], name: "index_items_on_outbound_log_id", using: :btree
    t.index ["product_id"], name: "index_items_on_product_id", using: :btree
    t.index ["shelf_id"], name: "index_items_on_shelf_id", using: :btree
  end

  create_table "outbound_logs", force: :cascade do |t|
    t.integer  "sale_order_id", null: false
    t.integer  "product_id",    null: false
    t.integer  "quantity",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["product_id"], name: "index_outbound_logs_on_product_id", using: :btree
    t.index ["sale_order_id"], name: "index_outbound_logs_on_sale_order_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "brand"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
  end

  create_table "sale_order_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.jsonb    "metadata",      default: {}
    t.integer  "sort_key",                   null: false
    t.integer  "sale_order_id",              null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["sale_order_id", "most_recent"], name: "index_sale_order_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
    t.index ["sale_order_id", "sort_key"], name: "index_sale_order_transitions_parent_sort", unique: true, using: :btree
  end

  create_table "sale_orders", force: :cascade do |t|
    t.boolean  "paid"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shelves", force: :cascade do |t|
    t.string   "name",                      null: false
    t.boolean  "warehouse",  default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name"], name: "UK_shelf_name", unique: true, using: :btree
  end

  add_foreign_key "inbound_logs", "inbound_orders"
  add_foreign_key "inbound_logs", "products"
  add_foreign_key "inbound_logs", "shelves"
  add_foreign_key "items", "inbound_logs"
  add_foreign_key "items", "outbound_logs"
  add_foreign_key "items", "products"
  add_foreign_key "outbound_logs", "products"
  add_foreign_key "outbound_logs", "sale_orders"
  add_foreign_key "products", "categories"
end
