# Preview all emails at http://localhost:3000/rails/mailers/student/user_mailer
class Student::UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student/user_mailer/welcome
  def connection_accepted_email
    @connection = Connection.first
    Student::UserMailer.with(connection: @connection).connection_accepted_email
  end

  def connection_declined_email
    @connection = Connection.first
    Student::UserMailer.with(connection: @connection).connection_declined_email
  end

end
