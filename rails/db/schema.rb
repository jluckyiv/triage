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

ActiveRecord::Schema.define(version: 20140629102622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: true do |t|
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbm_hearings_query_caches", force: true do |t|
    t.string   "court_code"
    t.string   "department"
    t.string   "date"
    t.text     "body"
    t.string   "md5"
    t.integer  "content_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbm_hearings_query_caches", ["court_code"], name: "index_cbm_hearings_query_caches_on_court_code", using: :btree
  add_index "cbm_hearings_query_caches", ["date"], name: "index_cbm_hearings_query_caches_on_date", using: :btree
  add_index "cbm_hearings_query_caches", ["department"], name: "index_cbm_hearings_query_caches_on_department", using: :btree
  add_index "cbm_hearings_query_caches", ["md5"], name: "index_cbm_hearings_query_caches_on_md5", using: :btree

  create_table "cbm_parties_query_caches", force: true do |t|
    t.string   "court_code"
    t.string   "case_type"
    t.string   "case_number"
    t.text     "body"
    t.string   "md5"
    t.integer  "content_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbm_parties_query_caches", ["case_number"], name: "index_cbm_parties_query_caches_on_case_number", using: :btree
  add_index "cbm_parties_query_caches", ["case_type"], name: "index_cbm_parties_query_caches_on_case_type", using: :btree
  add_index "cbm_parties_query_caches", ["court_code"], name: "index_cbm_parties_query_caches_on_court_code", using: :btree

  create_table "events", force: true do |t|
    t.integer  "matter_id"
    t.string   "category"
    t.string   "subject"
    t.string   "action"
    t.integer  "timestamp",  limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["action"], name: "index_events_on_action", using: :btree
  add_index "events", ["category"], name: "index_events_on_category", using: :btree
  add_index "events", ["matter_id"], name: "index_events_on_matter_id", using: :btree
  add_index "events", ["subject"], name: "index_events_on_subject", using: :btree
  add_index "events", ["timestamp"], name: "index_events_on_timestamp", using: :btree

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

  create_table "matters", force: true do |t|
    t.integer  "calendar_id"
    t.string   "case_number"
    t.string   "department"
    t.string   "petitioner"
    t.string   "respondent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matters", ["calendar_id"], name: "index_matters_on_calendar_id", using: :btree
  add_index "matters", ["case_number"], name: "index_matters_on_case_number", using: :btree
  add_index "matters", ["department"], name: "index_matters_on_department", using: :btree
  add_index "matters", ["petitioner"], name: "index_matters_on_petitioner", using: :btree
  add_index "matters", ["respondent"], name: "index_matters_on_respondent", using: :btree

end
