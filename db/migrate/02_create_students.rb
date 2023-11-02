class CreateStudents < ActiveRecord::Migration[7.1]
    def change
      create_table :students do |t|
        t.text :email
        t.text :passcode
        t.text :name
        t.text :course
        t.text :schedule
        t.text :tag
        t.text :text
        t.datetime :created_at, null: false
        t.datetime :updated_at, null: false
  
        t.index :email, name: 'index_students_on_email'
      end
    end
end