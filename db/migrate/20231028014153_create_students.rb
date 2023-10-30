class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.text :email, index: true
      t.text :passcode
      t.text :name
      t.text :course
      t.text :schedule
      t.text :tag
      t.text :text

      t.timestamps
    end
  end
end
