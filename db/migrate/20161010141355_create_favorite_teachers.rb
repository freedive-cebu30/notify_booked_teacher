class CreateFavoriteTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_teachers do |t|
      t.references :user, foreign_key: true
      t.references :teacher, foreign_key: true
      t.boolean :deleted

      t.timestamps
    end
  end
end
