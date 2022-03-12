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
    works = Work.by_adivisor_or_co_advisor(current_user).by_owner_or_member(@student).distinct

    @works_advising = works.in_progress.page(params[:page])
    @works_advised = works.concluded.page(params[:page])
  end
end
