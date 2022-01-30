class Student::EventsController < Student::BaseController
  before_action :fetch_work
  before_action :fetch_event, only: [:show, :edit, :update, :destroy]
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
      redirect_to student_events_path(work_id: @work.id), notice: 'Evento adicionado'
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

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @event.update(event_params)
      redirect_to request.referrer, notice: 'Evento atualizado'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to request.referrer, notice: 'Evento removido'
  end

  private

  def fetch_work
    @work = Work.by_owner_or_member(@current_user).find(params[:work_id])
  end

  def fetch_event
    @event = @work.events.find(params[:id])
  end

  def fetch_events
    current_date = DateTime.current

    @events = @work.events.order(event_date: :asc, title: :asc)

    @today_events = @events.where(event_date: current_date..current_date.end_of_day).first(6)
    @week_events = @events.where(event_date: current_date..current_date.end_of_week(:sunday)).first(6)
    @month_events = @events.where(event_date: current_date..current_date.end_of_month).first(6)
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
