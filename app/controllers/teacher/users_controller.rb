class Teacher::UsersController < Teacher::BaseController
  skip_before_action :authenticate, :verify_user_profile, :fetch_menu_notifications

  def create
    @user = Teacher::User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to sign_in_path, notice: "Criado com sucesso." }
      else
        format.js
      end
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
