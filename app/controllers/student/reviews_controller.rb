class Student::ReviewsController < Student::BaseController
  before_action :fetch_work
  before_action :fetch_work_versions
  before_action :fetch_review, only: [:show, :replace]

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

  def new
    @review = @work.reviews.new
  end

  def create
    @review = @work.reviews.new(review_params.merge!(created_by_id: @current_user.id))
    if @review.save
      redirect_to student_reviews_path(work_id: @work.id), notice: 'Revisão adicionada, aguarde seu orientador aprovar.'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def replace
    @review.transactional do
      @review.closed!
      @review.update!(confirmed: true, confirmed_by_id: @current_user.id, confirmed_at: DateTime.current)
      @review.old_work_version.update!(current: false)
      @review.new_work_version.update!(current: true)
    end

    redirect_to student_review_path(id: @review, work_id: @work.id), notice: 'Versão atual substituída.'
  end

  private

  def fetch_review
    @review = @work.reviews.find(params[:id])
  end

  def fetch_work
    @work = Work.by_owner_or_member(@current_user).find(params[:work_id])
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
