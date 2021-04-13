class Student::UserMailer < ApplicationMailer
  layout 'student/mailer'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student.user_mailer.welcome.subject
  #
  def connection_accepted_email
    @connection = params[:connection]

    mail to: @connection.student.email, subject: "Pedido de conexão aceito!"
  end

  def connection_declined_email
    @connection = params[:connection]

    mail to: @connection.student.email, subject: "Pedido de conexão recusado!"
  end
end
