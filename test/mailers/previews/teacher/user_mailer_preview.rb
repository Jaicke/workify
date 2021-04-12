# Preview all emails at http://localhost:3000/rails/mailers/teacher/user_mailer
class Teacher::UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/teacher/user_mailer/send_connection_email
  def send_connection_email
    @connection = Connection.first
    Teacher::UserMailer.with(connection: @connection).send_connection_email
  end

end
