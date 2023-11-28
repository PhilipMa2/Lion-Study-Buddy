class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :creator_id
      t.string :course
      t.integer :capacity
      t.text :focus
      t.text :text
      t.string :group_status, default: 'open'
    end

    add_foreign_key :groups, :students, column: :creator_id
    add_index :groups, :creator_id
  end
end
