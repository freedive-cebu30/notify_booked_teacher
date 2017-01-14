class DeleteColumnFromTeacher < ActiveRecord::Migration[5.0]
  def change
    remove_column :teachers, :user_id, :integer
  end
end
