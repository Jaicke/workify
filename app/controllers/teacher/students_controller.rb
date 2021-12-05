class Teacher::StudentsController < Teacher::BaseController
  before_action :fetch_student, only: [:show]
  before_action :fetch_works, only: [:show]

  def index
    @students = @current_user.students.order(:first_name).page(params[:page])

    @students = @students.search_by_name(params[:search]) if params[:search].present?

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  private

  def fetch_student
    @student = Student::User.find(params[:id])
  end

  def fetch_works
    work_ids = @student.works.joins(:co_advisors).where('advisor_id = :current_user_id OR teacher_users_works.user_id = :current_user_id', current_user_id: @current_user.id)

    @works_advising = Work.where(id: work_ids).in_progress.page(params[:page])
    @works_advised = Work.where(id: work_ids).complete.page(params[:page])
  end
end
