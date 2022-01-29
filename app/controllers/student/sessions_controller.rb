class Student::SessionsController < Student::BaseController
  skip_before_action :authenticate, :verify_user_profile, :fetch_menu_notifications

  def create
    user = Student::User.find_by_email(params[:email])
    respond_to do |format|
      if user&.authenticate(params[:password])
        session[:student_user_id] = user.id
        format.html { redirect_to student_home_index_path }
      else
        format.js
      end
    end
  end

  def destroy
    session[:student_user_id] = nil
    redirect_to sign_in_path
  end
end
