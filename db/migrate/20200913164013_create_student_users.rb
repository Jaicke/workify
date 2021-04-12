class CreateStudentUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :student_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :college_id
      t.integer :course_id
      t.integer :class_shift
      t.integer :ingress_year
      t.integer :ingress_semester
      t.integer :serie
      t.string :password_digest

      t.timestamps
    end
    add_index :student_users, :first_name
    add_index :student_users, :last_name
    add_index :student_users, :email
    add_index :student_users, :college_id
    add_index :student_users, :course_id
    add_index :student_users, :class_shift
    add_index :student_users, :ingress_year
    add_index :student_users, :ingress_semester
    add_index :student_users, :serie
  end
end
