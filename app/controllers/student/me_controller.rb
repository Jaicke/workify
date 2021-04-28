class Student::MeController < Student::BaseController
  skip_before_action :verify_user_profile

  before_action :set_user
  before_action :set_colleges, :set_courses, only: [:edit_profile, :update]

  def edit_profile
  end

  def update
    if @user.update(user_params)
      redirect_to edit_profile_student_me_path, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit_profile
    end
  end

  def change_password
  end

  def update_password
    if @user&.authenticate(params[:current_password])
      if user_params[:password] == user_params[:password_confirmation] and @user.update_attribute(:password, user_params[:password])
        redirect_to change_password_student_me_path, notice: 'Senha atualizada com sucesso'
      else
        redirect_to change_password_student_me_path, alert: "Confirmação de Senha não está igual a Senha."
      end
    else
      redirect_to change_password_student_me_path, alert: 'Senha atual incorreta.'
    end
  end

  def remove_avatar
    @user.avatar.purge
    redirect_to edit_profile_student_me_path, notice: 'Sua foto de perfil foi removida.'
  end

  private

  def set_user
    @user = Student::User.find(current_user.id)
  end

  def set_colleges
    @colleges = College.order(:name)
  end

  def set_courses
    @courses = Course.order(:name)
  end

  def user_params
    params.require(:student_user).permit(:first_name, :last_name, :email, :avatar, :college_id, :course_id, :class_shift, :ingress_semester, :ingress_year, :serie, :password, :password_confirmation)
  end

end
