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

ActiveRecord::Schema.define(version: 20170614144019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor", primary_key: "actor_id", force: :cascade do |t|
    t.string   "first_name",  limit: 45,                   null: false
    t.string   "last_name",   limit: 45,                   null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  add_index "actor", ["last_name"], name: "idx_5001419_idx_actor_last_name", using: :btree

  create_table "address", primary_key: "address_id", force: :cascade do |t|
    t.string   "address",     limit: 50,                   null: false
    t.string   "address2",    limit: 50
    t.string   "district",    limit: 20,                   null: false
    t.integer  "city_id",     limit: 2,                    null: false
    t.string   "postal_code", limit: 10
    t.string   "phone",       limit: 20,                   null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  add_index "address", ["city_id"], name: "idx_5001426_idx_fk_city_id", using: :btree

  create_table "blazer_audits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "query_id"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "query_id"
    t.string   "state"
    t.string   "schedule"
    t.text     "emails"
    t.string   "check_type"
    t.text     "message"
    t.datetime "last_run_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.integer  "dashboard_id"
    t.integer  "query_id"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.integer  "creator_id"
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "description"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "category", primary_key: "category_id", force: :cascade do |t|
    t.string   "name",        limit: 25,                   null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  create_table "city", primary_key: "city_id", force: :cascade do |t|
    t.string   "city",        limit: 50,                   null: false
    t.integer  "country_id",  limit: 2,                    null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  add_index "city", ["country_id"], name: "idx_5001440_idx_fk_country_id", using: :btree

  create_table "country", primary_key: "country_id", force: :cascade do |t|
    t.string   "country",     limit: 50,                   null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  create_table "customer", primary_key: "customer_id", force: :cascade do |t|
    t.integer  "store_id",    limit: 2,                    null: false
    t.string   "first_name",  limit: 45,                   null: false
    t.string   "last_name",   limit: 45,                   null: false
    t.string   "email",       limit: 50
    t.integer  "address_id",  limit: 2,                    null: false
    t.boolean  "active",                 default: true,    null: false
    t.datetime "create_date",                              null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  add_index "customer", ["address_id"], name: "idx_5001454_idx_fk_address_id", using: :btree
  add_index "customer", ["last_name"], name: "idx_5001454_idx_last_name", using: :btree
  add_index "customer", ["store_id"], name: "idx_5001454_idx_fk_store_id", using: :btree

# Could not dump table "film" because of following StandardError
#   Unknown type 'film_rating' for column 'rating'

  create_table "film_actor", id: false, force: :cascade do |t|
    t.integer  "actor_id",    limit: 2,                   null: false
    t.integer  "film_id",     limit: 2,                   null: false
    t.datetime "last_update",           default: "now()", null: false
  end

  add_index "film_actor", ["film_id"], name: "idx_5001474_idx_fk_film_id", using: :btree

  create_table "film_category", id: false, force: :cascade do |t|
    t.integer  "film_id",     limit: 2,                   null: false
    t.integer  "category_id", limit: 2,                   null: false
    t.datetime "last_update",           default: "now()", null: false
  end

  add_index "film_category", ["category_id"], name: "idx_5001478_fk_film_category_category", using: :btree

  create_table "film_text", primary_key: "film_id", force: :cascade do |t|
    t.string "title",       limit: 255, null: false
    t.text   "description"
  end

  add_index "film_text", ["title", "description"], name: "idx_5001482_idx_title_description", using: :btree

  create_table "inventory", primary_key: "inventory_id", force: :cascade do |t|
    t.integer  "film_id",     limit: 2,                   null: false
    t.integer  "store_id",    limit: 2,                   null: false
    t.datetime "last_update",           default: "now()", null: false
  end

  add_index "inventory", ["film_id"], name: "idx_5001490_idx_fk_film_id", using: :btree
  add_index "inventory", ["store_id", "film_id"], name: "idx_5001490_idx_store_id_film_id", using: :btree

  create_table "language", primary_key: "language_id", force: :cascade do |t|
    t.string   "name",        limit: 20,                   null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  create_table "payment", primary_key: "payment_id", force: :cascade do |t|
    t.integer  "customer_id",  limit: 2,                                           null: false
    t.integer  "staff_id",     limit: 2,                                           null: false
    t.integer  "rental_id",    limit: 8
    t.decimal  "amount",                 precision: 5, scale: 2,                   null: false
    t.datetime "payment_date",                                                     null: false
    t.datetime "last_update",                                    default: "now()", null: false
  end

  add_index "payment", ["customer_id"], name: "idx_5001504_idx_fk_customer_id", using: :btree
  add_index "payment", ["rental_id"], name: "idx_5001504_fk_payment_rental", using: :btree
  add_index "payment", ["staff_id"], name: "idx_5001504_idx_fk_staff_id", using: :btree

  create_table "rental", primary_key: "rental_id", force: :cascade do |t|
    t.datetime "rental_date",                              null: false
    t.integer  "inventory_id",                             null: false
    t.integer  "customer_id",  limit: 2,                   null: false
    t.datetime "return_date"
    t.integer  "staff_id",     limit: 2,                   null: false
    t.datetime "last_update",            default: "now()", null: false
  end

  add_index "rental", ["customer_id"], name: "idx_5001511_idx_fk_customer_id", using: :btree
  add_index "rental", ["inventory_id"], name: "idx_5001511_idx_fk_inventory_id", using: :btree
  add_index "rental", ["rental_date", "inventory_id", "customer_id"], name: "idx_5001511_rental_date", unique: true, using: :btree
  add_index "rental", ["staff_id"], name: "idx_5001511_idx_fk_staff_id", using: :btree

  create_table "staff", primary_key: "staff_id", force: :cascade do |t|
    t.string   "first_name",  limit: 45,                   null: false
    t.string   "last_name",   limit: 45,                   null: false
    t.integer  "address_id",  limit: 2,                    null: false
    t.binary   "picture"
    t.string   "email",       limit: 50
    t.integer  "store_id",    limit: 2,                    null: false
    t.boolean  "active",                 default: true,    null: false
    t.string   "username",    limit: 16,                   null: false
    t.string   "password",    limit: 40
    t.datetime "last_update",            default: "now()", null: false
  end

  add_index "staff", ["address_id"], name: "idx_5001518_idx_fk_address_id", using: :btree
  add_index "staff", ["store_id"], name: "idx_5001518_idx_fk_store_id", using: :btree

  create_table "store", primary_key: "store_id", force: :cascade do |t|
    t.integer  "manager_staff_id", limit: 2,                   null: false
    t.integer  "address_id",       limit: 2,                   null: false
    t.datetime "last_update",                default: "now()", null: false
  end

  add_index "store", ["address_id"], name: "idx_5001529_idx_fk_address_id", using: :btree
  add_index "store", ["manager_staff_id"], name: "idx_5001529_idx_unique_manager", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "address", "city", primary_key: "city_id", name: "fk_address_city", on_update: :cascade, on_delete: :restrict
  add_foreign_key "city", "country", primary_key: "country_id", name: "fk_city_country", on_update: :cascade, on_delete: :restrict
  add_foreign_key "customer", "address", primary_key: "address_id", name: "fk_customer_address", on_update: :cascade, on_delete: :restrict
  add_foreign_key "customer", "store", primary_key: "store_id", name: "fk_customer_store", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film", "language", column: "original_language_id", primary_key: "language_id", name: "fk_film_language_original", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film", "language", primary_key: "language_id", name: "fk_film_language", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_actor", "actor", primary_key: "actor_id", name: "fk_film_actor_actor", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_actor", "film", primary_key: "film_id", name: "fk_film_actor_film", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_category", "category", primary_key: "category_id", name: "fk_film_category_category", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_category", "film", primary_key: "film_id", name: "fk_film_category_film", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventory", "film", primary_key: "film_id", name: "fk_inventory_film", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventory", "store", primary_key: "store_id", name: "fk_inventory_store", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payment", "customer", primary_key: "customer_id", name: "fk_payment_customer", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payment", "rental", primary_key: "rental_id", name: "fk_payment_rental", on_update: :cascade, on_delete: :nullify
  add_foreign_key "payment", "staff", primary_key: "staff_id", name: "fk_payment_staff", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rental", "customer", primary_key: "customer_id", name: "fk_rental_customer", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rental", "inventory", primary_key: "inventory_id", name: "fk_rental_inventory", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rental", "staff", primary_key: "staff_id", name: "fk_rental_staff", on_update: :cascade, on_delete: :restrict
  add_foreign_key "staff", "address", primary_key: "address_id", name: "fk_staff_address", on_update: :cascade, on_delete: :restrict
  add_foreign_key "staff", "store", primary_key: "store_id", name: "fk_staff_store", on_update: :cascade, on_delete: :restrict
  add_foreign_key "store", "address", primary_key: "address_id", name: "fk_store_address", on_update: :cascade, on_delete: :restrict
  add_foreign_key "store", "staff", column: "manager_staff_id", primary_key: "staff_id", name: "fk_store_staff", on_update: :cascade, on_delete: :restrict
end
