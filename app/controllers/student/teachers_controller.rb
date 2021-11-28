class Student::TeachersController < Student::BaseController
  before_action :fetch_teacher, only: :show
  before_action :fetch_works, only: :show

  def index
    @teachers = Teacher::User.by_college(@current_user.college_id)
                             .by_course(@current_user.course_id)
                             .order(:first_name)
                             .page(params[:page])

    @teachers = @teachers.search_by_name(params[:search]) if params[:search].present?
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  def send_connection
    connection = Connection.find_or_create_by!(teacher_id: params[:id], student_id: current_user.id, status: :pending)
    Teacher::UserMailer.with(connection: connection).send_connection_email.deliver_later
  end

  private

  def fetch_teacher
    @teacher = Teacher::User.find(params[:id])
  end

  def fetch_works
    work_ids = @teacher.works_advising.pluck(:id) + @teacher.works_co_advising.pluck(:id)

    @works_advising = Work.where(id: work_ids).in_progress.page(params[:page])
    @works_advised = Work.where(id: work_ids).complete.page(params[:page])
  end
end
