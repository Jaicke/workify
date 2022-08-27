class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :student_users, :colleges, column: :college_id
    add_foreign_key :student_users, :courses, column: :course_id

    add_foreign_key :colleges_teacher_users, :teacher_users, column: :user_id
    add_foreign_key :colleges_teacher_users, :colleges, column: :college_id

    add_foreign_key :courses_teacher_users, :teacher_users, column: :user_id
    add_foreign_key :courses_teacher_users, :courses, column: :course_id

    add_foreign_key :works, :student_users, column: :created_by_id
    add_foreign_key :works, :teacher_users, column: :advisor_id

    add_foreign_key :teacher_users_works, :teacher_users, column: :user_id
    add_foreign_key :teacher_users_works, :works, column: :work_id

    add_foreign_key :group_members, :works, column: :work_id

    add_foreign_key :work_versions, :works, column: :work_id
    add_foreign_key :work_versions, :student_users, column: :created_by_id

    add_foreign_key :reviews, :works, column: :work_id
    add_foreign_key :reviews, :student_users, column: :created_by_id
    add_foreign_key :reviews, :work_versions, column: :old_work_version_id
    add_foreign_key :reviews, :work_versions, column: :new_work_version_id

    add_foreign_key :approvals, :teacher_users, column: :teacher_id
    add_foreign_key :approvals, :reviews, column: :review_id

    add_foreign_key :review_events, :reviews, column: :review_id

    add_foreign_key :discussion_answers, :discussions, column: :discussion_id

    add_foreign_key :events, :works, column: :work_id

    add_foreign_key :comments, :comments, column: :parent_id
  end
end
