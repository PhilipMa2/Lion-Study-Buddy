class SimplifyStudent < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :course, :text
    remove_column :students, :schedule, :text
    remove_column :students, :focus, :text
  end
end
