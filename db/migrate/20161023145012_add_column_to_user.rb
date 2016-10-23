class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :teacher_limit, :integer, default: 10
    add_column :users, :teacher_count, :integer, default: 0
  end
end
