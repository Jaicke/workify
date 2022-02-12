class AddPasswordResetColumnsToStudentUser < ActiveRecord::Migration[5.2]
  def change
    add_column :student_users, :reset_password_token, :string
    add_column :student_users, :reset_password_sent_at, :datetime
  end
end
