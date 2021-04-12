class Teacher::SessionsController < Teacher::BaseController
  skip_before_action :authenticate

  def create
    user = Teacher::User.find_by_email(params[:email])
    respond_to do |format|
      if user&.authenticate(params[:password])
        session[:teacher_user_id] = user.id
        format.html { redirect_to teacher_home_index_path }
      else
        format.js
      end
    end
  end

  def destroy
    session[:teacher_user_id] = nil
    redirect_to sign_in_path
  end
end
