class CreateStudentsAttendPosts < ActiveRecord::Migration[7.1]
    def change
      create_table :student_attend_posts do |t|
        t.integer :student_id, null: false
        t.integer :post_id, null: false
        t.string :apply_status, default: 'pending'
  
        t.index :post_id, name: 'index_student_attend_posts_on_post_id'
        t.index :student_id, name: 'index_student_attend_posts_on_student_id'
      end
  
      add_foreign_key :posts, :students, column: :creator_id
      add_foreign_key :student_attend_posts, :posts
      add_foreign_key :student_attend_posts, :students
    end
end