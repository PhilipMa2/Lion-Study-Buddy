class CreatePosts < ActiveRecord::Migration[7.1]
    def change
      create_table :posts do |t|
        t.text :creator_name
        t.integer :creator_id
        t.text :course
        t.text :tag
        t.text :text
        t.string :status, default: 'pending'
        t.integer :start_slot
        t.integer :end_slot
        t.datetime :created_at, null: false
        t.datetime :updated_at, null: false
  
        t.index :creator_id, name: 'index_posts_on_creator_id'
      end
    end
end