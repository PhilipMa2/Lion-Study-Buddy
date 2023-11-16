class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :creator_id
      t.string :course
      t.integer :capacity
      t.text :tag
      t.text :text
      t.string :post_status, default: 'open'
    end

    add_foreign_key :posts, :students, column: :creator_id
    add_index :posts, :creator_id
  end
end
