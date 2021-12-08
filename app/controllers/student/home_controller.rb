class Student::HomeController < Student::BaseController
  def index
  end

  def events
    @events = Event.includes(:work).merge(Work.by_owner_or_member(@current_user)).references(:work)

    respond_to do |format|
      format.json
    end
  end
end
