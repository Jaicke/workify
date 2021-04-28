class CreateWorksTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teacher_users_works, id: false do |t|
      t.references :user
      t.references :work
    end
  end
end
