class Teacher::HomeController < Teacher::BaseController

  def index
  end

  def events
    @events = Event.includes(:work).merge(Work.by_adivisor_or_co_advisor(@current_user)).references(:work)

    respond_to do |format|
      format.json
    end
  end
end
