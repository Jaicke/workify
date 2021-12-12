class Student::HomeController < Student::BaseController
  before_action :fetch_notifications, only: :index

  def index
  end

  def events
    @events = Event.includes(:work).merge(Work.by_owner_or_member(@current_user)).references(:work)

    respond_to do |format|
      format.json
    end
  end

  private

  def fetch_notifications
    @notifications = @current_user.notifications.order(created_at: :desc).first(5)
  end
end
