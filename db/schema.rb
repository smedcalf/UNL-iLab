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

ActiveRecord::Schema.define(version: 20141115170500) do

  create_table "auth_tokens", force: true do |t|
    t.text     "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.string   "url"
    t.integer  "priority"
    t.text     "description"
    t.boolean  "completed",   default: false, null: false
    t.integer  "user_id"
  end

  create_table "instructor_terms", force: true do |t|
    t.integer  "instructor_id"
    t.string   "semester"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructor_terms", ["instructor_id"], name: "index_instructor_terms_on_instructor_id", using: :btree

  create_table "instructors", force: true do |t|
    t.string   "email"
    t.string   "classname"
    t.string   "semester"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "instructors_projects", id: false, force: true do |t|
    t.integer "instructor_id"
    t.integer "project_id"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "initial_capacity"
    t.integer  "sponsor_id"
    t.string   "sponsor_type"
    t.integer  "current_capacity"
    t.string   "semester"
    t.string   "proposal_file_name"
    t.string   "proposal_content_type"
    t.integer  "proposal_file_size"
    t.boolean  "active"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["sponsor_id", "sponsor_type"], name: "index_projects_on_sponsor_id_and_sponsor_type", using: :btree

  create_table "requests", force: true do |t|
    t.integer  "student_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "approved"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solutions", force: true do |t|
    t.string   "semester",                        null: false
    t.string   "name",                            null: false
    t.text     "csv",          limit: 2147483647, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "student_data", limit: 2147483647, null: false
    t.binary   "project_data", limit: 2147483647, null: false
  end

  create_table "sponsor_preferences", force: true do |t|
    t.integer  "student_id"
    t.integer  "project_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "organization"
    t.string   "email"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "sponsors", ["email"], name: "index_sponsors_on_email", unique: true, using: :btree

  create_table "student_preferences", force: true do |t|
    t.integer  "student_id"
    t.integer  "project_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_letter_content_type"
    t.string   "cover_letter_file_name"
    t.integer  "cover_letter_file_size"
    t.string   "resume_content_type"
    t.string   "resume_file_name"
    t.integer  "resume_file_size"
    t.string   "github_url"
    t.string   "google_plus_url"
  end

  create_table "students", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "major"
    t.string   "semester"
    t.string   "classname"
    t.integer  "availability"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "teams", force: true do |t|
    t.string  "name"
    t.integer "project_id"
    t.string  "google_drive"
    t.string  "trello_link"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "utype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_tokens"
    t.string   "email"
  end

  add_index "users", ["id"], name: "id", using: :btree

end
