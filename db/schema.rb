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

ActiveRecord::Schema[7.1].define(version: 3) do
  create_table "posts", force: :cascade do |t|
    t.integer "creator_id"
    t.string "course"
    t.integer "capacity"
    t.text "tag"
    t.text "text"
    t.string "post_status", default: "open"
    t.index ["creator_id"], name: "index_posts_on_creator_id"
  end

  create_table "student_attend_posts", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "post_id", null: false
    t.string "apply_status", default: "apply"
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
  end

  add_foreign_key "posts", "students", column: "creator_id"
  add_foreign_key "posts", "students", column: "creator_id"
  add_foreign_key "student_attend_posts", "posts"
  add_foreign_key "student_attend_posts", "students"
end
