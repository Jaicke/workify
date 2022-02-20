class Teacher::DiscussionsController < Teacher::BaseController
  before_action :fetch_work
  before_action :fetch_discussion, only: [:show, :edit, :update, :destroy, :change_status]
  before_action :fetch_discussion_answers, only: :show

  def index
    @discussions = @work.discussions.order(created_at: :desc).page(params[:page])
    @discussions = @discussions.where('title ILIKE ? OR ? ILIKE ANY (tags)', "%#{params[:search]}%", params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  def new
    @discussion = @work.discussions.new
  end

  def create
    @discussion = @work.discussions.new(discussion_params.merge!(created_by: @current_user))
    if @discussion.save
      redirect_to teacher_discussions_path(work_id: @work.id), notice: 'Discussão adicionada com sucesso'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to teacher_discussion_path(work_id: @work.id), notice: 'Discussão atualizada com sucesso.'
    else
      render :edit
    end
  end

  def change_status
    @discussion.update(closed: !@discussion.closed)

    notice = @discussion.closed? ? 'Discussão fechada.' : 'Discussão aberta.'

    redirect_to teacher_discussion_path(work_id: @work.id), notice: notice
  end

  def destroy
    @discussion.destroy
    redirect_to teacher_discussions_path(work_id: @work.id), notice: 'Discussão removida.'
  end

  private

  def fetch_work
    @work = Work.by_adivisor_or_co_advisor(@current_user).find(params[:work_id])
  end

  def fetch_discussion
    @discussion = @work.discussions.find(params[:id])
  end

  def fetch_discussion_answers
    @discussion_answers = @discussion.discussion_answers.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC, created_at DESC').page(params[:page])
  end

  def discussion_params
    params.require(:discussion).permit(
      :id,
      :title,
      :body,
      tags: []
    )
  end
end
