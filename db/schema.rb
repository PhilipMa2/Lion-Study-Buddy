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

ActiveRecord::Schema[7.1].define(version: 2023_11_15_002955) do
  create_table "posts", force: :cascade do |t|
    t.text "creator_name"
    t.integer "creator_id"
    t.text "course"
    t.text "tag"
    t.text "text"
    t.string "status", default: "pending"
    t.integer "start_slot"
    t.integer "end_slot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_posts_on_creator_id"
  end

  create_table "student_attend_posts", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_student_attend_posts_on_post_id"
    t.index ["student_id"], name: "index_student_attend_posts_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.text "email"
    t.text "passcode"
    t.text "name"
    t.text "course"
    t.text "schedule"
    t.text "tag"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email"
  end

  create_table "time_slots", force: :cascade do |t|
    t.integer "available_time"
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_time_slots_on_student_id"
  end

  add_foreign_key "posts", "students", column: "creator_id"
  add_foreign_key "student_attend_posts", "posts"
  add_foreign_key "student_attend_posts", "students"
  add_foreign_key "time_slots", "students"
end
