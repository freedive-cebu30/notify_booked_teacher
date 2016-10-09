class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.integer :online_teacher_id
      t.string :service_name
      t.references :user, foreign_key: true
      t.boolean :deleted

      t.timestamps
    end
  end
end
