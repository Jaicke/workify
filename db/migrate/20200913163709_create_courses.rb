class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name

      t.timestamps
    end
    add_index :courses, :name
  end
end
