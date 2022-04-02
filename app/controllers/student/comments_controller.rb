class Student::CommentsController < Student::BaseController
  before_action :fetch_comment, only: [:edit, :update, :destroy]

  def create
    comment = Comment.new(comment_params.merge!(created_by: @current_user))

    if comment.save
      redirect_to request.referrer
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @comment.update(body: params[:comment][:body], edited: true)
      redirect_to request.referrer, notice: 'Seu comentário foi atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to request.referrer
  end

  private

  def comment_params
    params.permit(
      :commentable_id,
      :commentable_type,
      :parent_id,
      :body
    )
  end

  def fetch_comment
    @comment = Comment.find(params[:id])
  end
end
