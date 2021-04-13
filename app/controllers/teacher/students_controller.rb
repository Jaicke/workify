class Teacher::StudentsController < Teacher::BaseController
  skip_before_action :authenticate, only: :answer_connection

  def answer_connection
    @connection = Connection.where(id: params[:id], status: :pending).last
    @answer = params[:answer]
    if @connection.present?
      accept_connection if @answer == 'accepted'
      decline_connection if @answer == 'declined'
    else
      @answer = nil
    end
  end

  private

  def accept_connection
    @connection.accepted!
    Student::UserMailer.with(connection: @connection).connection_accepted_email.deliver_later
  end

  def decline_connection
    @connection.declined!
    Student::UserMailer.with(connection: @connection).connection_declined_email.deliver_later
  end
end
