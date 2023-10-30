class CreateStudentAttendPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :student_attend_posts do |t|
      t.references :student, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
