class AddIndexToUserlessonLessonId < ActiveRecord::Migration[6.0]
  def change
    add_index :user_lessons, [:user_id, :lesson_id], unique: true
  end
end
