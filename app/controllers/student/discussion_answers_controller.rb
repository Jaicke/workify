class Student::DiscussionAnswersController < Student::BaseController
  before_action :fetch_work
  before_action :fetch_discussion
  before_action :fetch_discussion_answer, only: [:edit, :update, :destroy, :toggle_like]

  def create
    @discussion_answer = @discussion.discussion_answers.new(create_discussion_answer_params.merge!(created_by: @current_user))
    if @discussion_answer.save
      redirect_to student_discussion_path(id: @discussion.id, work_id: @work.id), notice: 'Sua resposta foi adicionada com sucesso'
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @discussion_answer.update(update_discussion_answer_params)
      redirect_to student_discussion_path(id: @discussion.id, work_id: @work.id), notice: 'Sua resposta foi atualizada com sucesso.'
    else
      render :edit
    end
  end

  def toggle_like
    ToggleLikeService.call!(@discussion_answer, @current_user)

    redirect_to student_discussion_path(id: @discussion.id, work_id: @work.id)
  end

  def destroy
    @discussion_answer.destroy
    redirect_to student_discussion_path(id: @discussion.id, work_id: @work.id), notice: 'Sua resposta foi removida.'
  end

  private

  def fetch_work
    @work = Work.by_owner_or_member(@current_user).find(params[:work_id])
  end

  def fetch_discussion
    @discussion = @work.discussions.find(params[:discussion_id])
  end

  def fetch_discussion_answer
    @discussion_answer = @discussion.discussion_answers.find(params[:id])
  end

  def update_discussion_answer_params
    params.require(:discussion_answer).permit(
      :content
    )
  end

  def create_discussion_answer_params
    params.permit(
      :content
    )
  end
end
