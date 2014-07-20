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

ActiveRecord::Schema.define(version: 20140714064541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree
  add_index "addresses", ["city"], name: "index_addresses_on_city", using: :btree
  add_index "addresses", ["state"], name: "index_addresses_on_state", using: :btree
  add_index "addresses", ["street1", "zip", "street2"], name: "index_addresses_on_street1_and_zip_and_street2", unique: true, using: :btree
  add_index "addresses", ["street1"], name: "index_addresses_on_street1", using: :btree
  add_index "addresses", ["zip"], name: "index_addresses_on_zip", using: :btree

  create_table "attorneys", force: true do |t|
    t.string   "name"
    t.string   "name_digest"
    t.integer  "sbn"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attorneys", ["name"], name: "index_attorneys_on_name", using: :btree
  add_index "attorneys", ["name_digest"], name: "index_attorneys_on_name_digest", unique: true, using: :btree
  add_index "attorneys", ["sbn"], name: "index_attorneys_on_sbn", unique: true, using: :btree

  create_table "courthouses", force: true do |t|
    t.string   "branch_name"
    t.string   "county"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courthouses", ["branch_name"], name: "index_courthouses_on_branch_name", unique: true, using: :btree
  add_index "courthouses", ["county"], name: "index_courthouses_on_county", using: :btree

  create_table "departments", force: true do |t|
    t.string   "name"
    t.integer  "courthouse_id"
    t.string   "judicial_officer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["courthouse_id"], name: "index_departments_on_courthouse_id", using: :btree
  add_index "departments", ["name"], name: "index_departments_on_name", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.integer  "matter_id"
    t.string   "category"
    t.string   "subject"
    t.string   "action"
    t.integer  "unix_timestamp", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["action", "subject", "category"], name: "index_events_on_action_and_subject_and_category", using: :btree
  add_index "events", ["action"], name: "index_events_on_action", using: :btree
  add_index "events", ["category"], name: "index_events_on_category", using: :btree
  add_index "events", ["matter_id"], name: "index_events_on_matter_id", using: :btree
  add_index "events", ["subject"], name: "index_events_on_subject", using: :btree
  add_index "events", ["unix_timestamp"], name: "index_events_on_unix_timestamp", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hearings", force: true do |t|
    t.integer  "matter_id"
    t.integer  "department_id"
    t.datetime "date_time"
    t.string   "interpreter"
    t.text     "description"
    t.string   "description_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hearings", ["date_time"], name: "index_hearings_on_date_time", using: :btree
  add_index "hearings", ["department_id"], name: "index_hearings_on_department_id", using: :btree
  add_index "hearings", ["description_digest"], name: "index_hearings_on_description_digest", using: :btree
  add_index "hearings", ["matter_id"], name: "index_hearings_on_matter_id", using: :btree

  create_table "matters", force: true do |t|
    t.string   "court_code"
    t.string   "case_type"
    t.string   "case_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matters", ["case_number", "case_type"], name: "index_matters_on_case_number_and_case_type", unique: true, using: :btree
  add_index "matters", ["case_number"], name: "index_matters_on_case_number", using: :btree
  add_index "matters", ["case_type"], name: "index_matters_on_case_type", using: :btree
  add_index "matters", ["court_code"], name: "index_matters_on_court_code", using: :btree

  create_table "names", force: true do |t|
    t.string   "first"
    t.string   "middle"
    t.string   "last"
    t.string   "suffix"
    t.integer  "nameable_id"
    t.string   "nameable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "names", ["first", "last"], name: "index_names_on_first_and_last", using: :btree
  add_index "names", ["first", "middle", "last", "suffix"], name: "index_names_on_first_and_middle_and_last_and_suffix", using: :btree
  add_index "names", ["first"], name: "index_names_on_first", using: :btree
  add_index "names", ["last"], name: "index_names_on_last", using: :btree
  add_index "names", ["middle"], name: "index_names_on_middle", using: :btree
  add_index "names", ["nameable_id", "nameable_type"], name: "index_names_on_nameable_id_and_nameable_type", using: :btree
  add_index "names", ["suffix"], name: "index_names_on_suffix", using: :btree

  create_table "parties", force: true do |t|
    t.integer  "matter_id"
    t.integer  "attorney_id"
    t.integer  "number"
    t.string   "role"
    t.datetime "dob"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parties", ["attorney_id"], name: "index_parties_on_attorney_id", using: :btree
  add_index "parties", ["matter_id"], name: "index_parties_on_matter_id", using: :btree
  add_index "parties", ["number"], name: "index_parties_on_number", using: :btree
  add_index "parties", ["role"], name: "index_parties_on_role", using: :btree

end
