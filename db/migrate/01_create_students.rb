class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.text :email
      t.text :passcode
      t.text :name
      t.text :course
      t.text :schedule
      t.text :tag
      t.text :text
    end
  end
end
