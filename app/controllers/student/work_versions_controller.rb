class Student::WorkVersionsController < Student::BaseController
  before_action :fetch_work
  before_action :fetch_work_version, only: [:show, :edit, :update, :destroy]

  def new
    @work_version = @work.work_versions.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @work_version = @work.work_versions.new(work_version_params.merge!(created_by_id: @current_user.id))
    respond_to do |format|
      if @work_version.save
        format.html { redirect_to student_work_path(id: @work), notice: 'Versão adicionada' }
      else
        format.html { redirect_to student_work_path(id: @work), alert: @work_version.errors.full_messages.join(', ') }
        format.js { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @work_version.update(work_version_params)
        format.html { redirect_to student_work_path(id: @work), notice: 'Versão atualizada' }
      else
        format.js { render :edit }
      end
    end
  end

  def show
  end

  private

  def work_version_params
    params.require(:work_version).permit(:title, :file)
  end

  def fetch_work_version
    @work_version = @work.work_versions.find(params[:id])
  end

  def fetch_work
    @work = Work.by_owner_or_member(@current_user).find(params[:work_id])
  end
end
