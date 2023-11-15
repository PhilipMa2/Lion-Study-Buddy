class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.integer :available_time
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
