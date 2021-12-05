class Teacher::ReviewsController < Teacher::BaseController
  before_action :fetch_work
  before_action :fetch_work_versions
  before_action :fetch_review, only: [:show, :approve]

  def index
    @reviews = @work.reviews.order(created_at: :desc).page(params[:page])
    @reviews = @reviews.where('title ILIKE ?', "%#{params[:search]}%") if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  def approve
    @review.approvals.create!(teacher_id: @current_user.id)

    redirect_to teacher_review_path(id: @review, work_id: @work.id), notice: 'Revisão aprovada'
  end

  private

  def fetch_review
    @review = @work.reviews.find(params[:id])
  end

  def fetch_work
    @work = Work.by_adivisor_or_co_advisor(@current_user).find(params[:work_id])
  end

  def fetch_work_versions
    @work_versions = @work.work_versions.where(current: false)
  end

  def review_params
    params.require(:review).permit(
      :id,
      :title,
      :description,
      :new_work_version_id
    )
  end
end
