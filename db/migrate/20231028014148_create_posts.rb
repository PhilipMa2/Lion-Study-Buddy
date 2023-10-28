class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.text :creator_name
      t.references :creator, foreign_key: { to_table: :students }
      t.text :course
      t.text :schedule
      t.text :tag
      t.text :text

      t.timestamps
    end
  end
end
