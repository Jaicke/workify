class Teacher::NotificationsController < Teacher::BaseController
  before_action :fetch_notification, only: :read

  def index
    @notifications = @current_user.notifications.order(created_at: :desc).page(params[:page])
  end

  def read
    @notification.update(read: true)
  end

  private

  def fetch_notification
    @notification = @current_user.notifications.find(params[:id])
  end
end
