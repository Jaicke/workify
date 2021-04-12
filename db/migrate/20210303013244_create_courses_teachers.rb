class CreateCoursesTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :courses_teacher_users, id: false do |t|
      t.references :user
      t.references :course
    end
  end
end
