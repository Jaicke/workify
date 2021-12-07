class Teacher::EventsController < Teacher::BaseController
  before_action :fetch_work
  before_action :fetch_event, only: [:show]
  before_action :fetch_events, only: :index

  def index
    @events = @work.events

    respond_to do |format|
      format.json
      format.html
    end
  end

  def new
    @event = @work.events.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @event = @work.events.new(event_params.merge!(created_by: @current_user))
    if @event.save
      redirect_to teacher_events_path(work_id: @work.id), notice: 'Evento adicionado com sucesso'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def fetch_work
    @work = Work.by_adivisor_or_co_advisor(@current_user).find(params[:work_id])
  end

  def fetch_event
    @event = @work.events.find(params[:id])
  end

  def fetch_events
    current_date = DateTime.current

    @events = @work.events.order(event_date: :asc, title: :asc)
    @today_events = @events.where(event_date: current_date.beginning_of_day..current_date.end_of_day).first(6)
    @week_events = @events.where(event_date: current_date.beginning_of_week(:sunday)..current_date.end_of_week(:sunday)).first(6)
    @month_events = @events.where(event_date: current_date.beginning_of_month..current_date.end_of_month).first(6)
  end

  def event_params
    params.require(:event).permit(
      :id,
      :title,
      :description,
      :event_date,
      :online,
      :place,
      :room_url,
      :color
    )
  end
end
