class Student::WorksController < Student::BaseController
  before_action :fetch_work, only: [:edit, :update, :destroy, :show]
  before_action :fetch_teachers, only: [:new, :create, :edit, :update]
  before_action :fetch_work_versions, only: :show

  def index
    @works = Work.left_joins(:group_members)
                 .where('created_by_id = ? OR group_members.email = ?', @current_user.id , @current_user.email)
                 .order(created_at: :desc)
                 .distinct
                 .page(params[:page])

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

  def new
    @work = @current_user.works.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @work = Work.new(work_params.merge!(created_by_id: @current_user.id))
    if @work.save
      redirect_to student_works_path, notice: 'Trabalho adicionado.'
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @work.update(work_params)
      redirect_to student_works_path, notice: 'Trabalho atualizado.'
    else
      render :edit
    end
  end

  def destroy
    #TODO Avisar aos orientadores?
    @work.destroy
    redirect_to student_works_path, notice: 'Trabalho removido.'
  end

  private

  def work_params
    params.require(:work).permit(
      :theme,
      :description,
      :group,
      :advisor_id,
      co_advisor_ids: [],
      group_members_attributes:[
        :id,
        :email,
        :_destroy
      ]
    )
  end

  def fetch_work
    @work = Work.find(params[:id])
  end

  def fetch_teachers
    teachers_ids = @current_user.teachers.pluck(:id)
    teachers_ids = teachers_ids.concat(@work.created_by.teachers.pluck(:id)) if @work
    @teachers = Teacher::User.where(id: teachers_ids)
  end

  def fetch_work_versions
    @current_work_version = @work.work_versions.where(current: true).last

    @work_versions = @work.work_versions
                          .order(current: :desc)
                          .order(created_at: :desc)
                          .order(:title)
                          .page(params[:page])
    @work_versions = @work_versions.where('title ILIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

end
