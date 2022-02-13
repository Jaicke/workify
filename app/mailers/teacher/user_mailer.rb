class Teacher::UserMailer < ApplicationMailer
  layout 'teacher/mailer'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher.user_mailer.send_connection_email.subject
  #
  def send_connection_email
    @connection = params[:connection]
    @teacher = @connection.teacher

    mail to: @teacher.email, subject: "Pedido de conexão"
  end

  def password_reset_email
    @user = params[:user]
    @user.generate_password_token!
    @token = @user.reset_password_token

    mail to: @user.email, subject: 'Instruções de redefinição de senha'
  end
end
