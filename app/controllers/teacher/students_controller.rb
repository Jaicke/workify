class Teacher::StudentsController < Teacher::BaseController
  skip_before_action :authenticate, only: :answer_connection

  def answer_connection
    connection = Connection.where(id: params[:id], status: :pending).last
    @answer = params[:answer]
    if connection.present?
      connection.accepted! if @answer == 'accepted'
      connection.declined! if @answer == 'declined'
    else
      @answer = nil
    end
  end

end
