class Teacher::WorksController < Teacher::BaseController
  before_action :fetch_work, only: :show
  before_action :fetch_members, only: :show

  def index
    @works = Work.by_adivisor_or_co_advisor(@current_user).page(params[:page])

    @works = @works.where('theme ILIKE ?', "%#{params[:search]}%") if params[:search].present?
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def fetch_work
    @work = Work.by_adivisor_or_co_advisor(@current_user).find(params[:id])
  end

  def fetch_members
    @members = Student::User.where(email: @work.group_members.pluck(:email))
  end

end
