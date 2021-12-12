class Student::ReviewsController < Student::BaseController
  before_action :fetch_work
  before_action :fetch_work_versions
  before_action :fetch_review, only: [:show, :replace, :edit, :update, :close]

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
    @review = @work.reviews.new(review_params.merge!(created_by: @current_user))
    if @review.save
      ReviewEvent.create!(review_id: @review.id, by_user: @current_user, action: :created)
      redirect_to student_reviews_path(work_id: @work.id), notice: 'Revisão adicionada, aguarde seu orientador aprovar.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @work_versions = @work.work_versions

    if @review.update(review_params)
      redirect_to student_review_path(id: @review, work_id: @work.id), notice: 'Revisão atualizada com sucesso.'
    else
      render :edit
    end
  end

  def replace
    @review.confirm_replace
    ReviewEvent.create!(review_id: @review.id, by_user: @current_user, action: :closed)
    ReviewEvent.create!(review_id: @review.id, by_user: @current_user, action: :confirmed)
    redirect_to student_review_path(id: @review, work_id: @work.id), notice: 'Versão atual substituída.'
  end

  def close
    @review.closed!
    ReviewEvent.create!(review_id: @review.id, by_user: @current_user, action: :closed)
    redirect_to student_review_path(id: @review, work_id: @work.id), notice: 'Revisão fechada.'
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
