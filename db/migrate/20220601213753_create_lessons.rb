class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.time :start_time
      t.time :duration
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
