class Teacher::ConnectionsController < Teacher::BaseController
  before_action :fetch_connection

  def index
    @answer = params[:answer]
  end

  def accept
    if @connection
      Teacher::ConnectionService.accept!(@connection)
      @answer = 'accepted'
    end

    redirect_to teacher_connections_path(answer: @answer)
  end

  def decline
    if @connection
      Teacher::ConnectionService.decline!(@connection)
      @answer = 'declined'
    end

    redirect_to teacher_connections_path(answer: @answer)
  end

  private

  def fetch_connection
    @connection = @current_user.connections.find_by(id: params[:id], status: :pending)
  end
end
