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

ActiveRecord::Schema.define(version: 20150211035430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cycle_weights", force: :cascade do |t|
    t.integer  "weight_id"
    t.integer  "cycle_id"
    t.string   "flag",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cycles", force: :cascade do |t|
    t.integer  "starting_weight_id"
    t.integer  "program_id"
    t.integer  "cycle_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.string   "program_type", limit: 255
  end

  create_table "schemes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcycles", force: :cascade do |t|
    t.integer  "cycle_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "date_of_birth"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weights", force: :cascade do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.string   "unit",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weightable_id"
    t.string   "weightable_type", limit: 255
  end

  create_table "workout_sets", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "workout_id"
    t.integer  "intended_reps"
    t.integer  "weight"
    t.integer  "performed_reps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "options"
    t.integer  "weight_id"
  end

  add_index "workout_sets", ["exercise_id"], name: "index_workout_sets_on_exercise_id", using: :btree

  create_table "workouts", force: :cascade do |t|
    t.integer  "subcycle_id"
    t.datetime "workout_date"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["subcycle_id"], name: "index_workouts_on_subcycle_id", using: :btree

end
