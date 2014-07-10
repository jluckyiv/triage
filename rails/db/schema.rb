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

ActiveRecord::Schema.define(version: 20140710050019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "case_numbers", force: true do |t|
    t.string   "court_code"
    t.string   "case_type"
    t.string   "case_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_numbers", ["case_number", "case_type"], name: "index_case_numbers_on_case_number_and_case_type", using: :btree
  add_index "case_numbers", ["case_number"], name: "index_case_numbers_on_case_number", using: :btree
  add_index "case_numbers", ["case_type"], name: "index_case_numbers_on_case_type", using: :btree
  add_index "case_numbers", ["court_code"], name: "index_case_numbers_on_court_code", using: :btree

  create_table "cbm_hearings_query_caches", force: true do |t|
    t.string   "court_code"
    t.string   "department"
    t.string   "date"
    t.string   "md5"
    t.integer  "content_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbm_hearings_query_caches", ["court_code"], name: "index_cbm_hearings_query_caches_on_court_code", using: :btree
  add_index "cbm_hearings_query_caches", ["date", "department", "court_code"], name: "index_cbm_hearings_query_caches_on_date_dept_cc", unique: true, using: :btree
  add_index "cbm_hearings_query_caches", ["date"], name: "index_cbm_hearings_query_caches_on_date", using: :btree
  add_index "cbm_hearings_query_caches", ["department"], name: "index_cbm_hearings_query_caches_on_department", using: :btree
  add_index "cbm_hearings_query_caches", ["md5"], name: "index_cbm_hearings_query_caches_on_md5", using: :btree

  create_table "cbm_parties_query_caches", force: true do |t|
    t.string   "court_code"
    t.string   "case_type"
    t.string   "case_number"
    t.string   "md5"
    t.integer  "content_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbm_parties_query_caches", ["case_number", "case_type"], name: "index_cbm_parties_query_caches_on_case_number_and_case_type", using: :btree
  add_index "cbm_parties_query_caches", ["case_number"], name: "index_cbm_parties_query_caches_on_case_number", using: :btree
  add_index "cbm_parties_query_caches", ["case_type"], name: "index_cbm_parties_query_caches_on_case_type", using: :btree
  add_index "cbm_parties_query_caches", ["court_code"], name: "index_cbm_parties_query_caches_on_court_code", using: :btree
  add_index "cbm_parties_query_caches", ["md5"], name: "index_cbm_parties_query_caches_on_md5", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: true do |t|
    t.integer  "matter_id"
    t.string   "category"
    t.string   "subject"
    t.string   "action"
    t.integer  "timestamp",  limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["action", "subject", "category"], name: "index_events_on_action_and_subject_and_category", using: :btree
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

  create_table "hearings", force: true do |t|
    t.integer  "matter_id"
    t.string   "time"
    t.text     "description"
    t.string   "interpreter"
    t.string   "md5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hearings", ["matter_id"], name: "index_hearings_on_matter_id", using: :btree
  add_index "hearings", ["md5", "matter_id", "time"], name: "index_hearings_on_md5_and_matter_id_and_time", unique: true, using: :btree
  add_index "hearings", ["md5"], name: "index_hearings_on_md5", using: :btree
  add_index "hearings", ["time"], name: "index_hearings_on_time", using: :btree

  create_table "matters", force: true do |t|
    t.integer  "case_number_id"
    t.string   "date"
    t.string   "department"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matters", ["case_number_id"], name: "index_matters_on_case_number_id", using: :btree
  add_index "matters", ["date", "department"], name: "index_matters_on_date_and_department", using: :btree
  add_index "matters", ["date"], name: "index_matters_on_date", using: :btree
  add_index "matters", ["department"], name: "index_matters_on_department", using: :btree

  create_table "parties", force: true do |t|
    t.integer  "case_number_id"
    t.integer  "number"
    t.string   "category"
    t.string   "first"
    t.string   "middle"
    t.string   "last"
    t.string   "suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parties", ["case_number_id"], name: "index_parties_on_case_number_id", using: :btree
  add_index "parties", ["category"], name: "index_parties_on_category", using: :btree
  add_index "parties", ["first"], name: "index_parties_on_first", using: :btree
  add_index "parties", ["last", "first"], name: "index_parties_on_last_and_first", using: :btree
  add_index "parties", ["last"], name: "index_parties_on_last", using: :btree
  add_index "parties", ["middle"], name: "index_parties_on_middle", using: :btree
  add_index "parties", ["number"], name: "index_parties_on_number", using: :btree
  add_index "parties", ["suffix"], name: "index_parties_on_suffix", using: :btree

end
