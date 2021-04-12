class CreateCollegesTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :colleges_teacher_users, id: false do |t|
      t.references :user
      t.references :college
    end
  end
end
