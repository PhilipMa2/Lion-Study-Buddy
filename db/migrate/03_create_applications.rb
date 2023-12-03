class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.integer :student_id, null: false
      t.integer :group_id, null: false
      t.string :application_status, default: 'pending'
  
      t.index :student_id, name: 'index_applications_on_student_id'
      t.index :group_id, name: 'index_applications_on_group_id'
    end
  
    add_foreign_key :applications, :students
    add_foreign_key :applications, :groups
  end
end