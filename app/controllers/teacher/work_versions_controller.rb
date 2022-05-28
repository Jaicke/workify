class Teacher::WorkVersionsController < Teacher::BaseController
  before_action :fetch_work
  before_action :fetch_work_version, only: :show
  before_action :fetch_current_work_version, only: :current_version

  def show
  end

  def current_version
  end

  private

  def fetch_current_work_version
    @work_version = @work.current_version
  end

  def fetch_work_version
    @work_version = @work.work_versions.find(params[:id])
  end

  def fetch_work
    @work = Work.by_adivisor_or_co_advisor(@current_user).find(params[:work_id])
  end
end
