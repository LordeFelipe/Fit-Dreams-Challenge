class AddIndexToLessonName < ActiveRecord::Migration[6.0]
  def change
    add_index :lessons, :name, unique: true
  end
end
