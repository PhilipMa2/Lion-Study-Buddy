# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_02_200845) do
  create_table "applications", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "group_id", null: false
    t.string "application_status", default: "pending"
    t.index ["group_id"], name: "index_applications_on_group_id"
    t.index ["student_id"], name: "index_applications_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_id"
    t.string "course_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "creator_id"
    t.string "course"
    t.integer "capacity"
    t.text "focus"
    t.text "text"
    t.string "group_status", default: "open"
    t.index ["creator_id"], name: "index_groups_on_creator_id"
  end

  create_table "students", force: :cascade do |t|
    t.text "email"
    t.text "passcode"
    t.text "name"
    t.text "course"
    t.text "schedule"
    t.text "focus"
    t.text "text"
  end

  create_table "time_slots", force: :cascade do |t|
    t.integer "available_time"
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_time_slots_on_student_id"
  end

  add_foreign_key "applications", "groups"
  add_foreign_key "applications", "students"
  add_foreign_key "groups", "students", column: "creator_id"
  add_foreign_key "time_slots", "students"
end
