class Student::DiscussionsController < Student::BaseController
  before_action :fetch_work

  def index
    @discussions = @work.discussions.order(created_at: :desc).page(params[:page])
    @discussions = @discussions.where('title ILIKE ? OR ? ILIKE ANY (tags)', "%#{params[:search]}%", params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @discussion = @work.discussions.new
  end

  def create
    @discussion = @work.discussions.new(discussion_params.merge!(created_by: @current_user))
    if @discussion.save
      redirect_to student_discussions_path(work_id: @work.id), notice: 'Discussão adicionada com sucesso'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to student_discussions_path(work_id: @work.id), notice: 'Discussão atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to student_discussions_path(work_id: @work.id), notice: 'Discussão removida.'
  end

  private

  def fetch_work
    @work = Work.by_owner_or_member(@current_user).find(params[:work_id])
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
