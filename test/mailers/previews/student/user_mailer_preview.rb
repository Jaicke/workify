# Preview all emails at http://localhost:3000/rails/mailers/student/user_mailer
class Student::UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student/user_mailer/welcome
  def welcome
    Student::UserMailer.welcome
  end

end
