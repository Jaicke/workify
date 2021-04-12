class Teacher::MeController < Teacher::BaseController
  before_action :set_colleges, :set_courses, only: [:edit_profile, :update]

  def edit_profile
  end

  def update
    if @current_user.update(user_params)
      redirect_to edit_profile_teacher_me_path, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit_profile
    end
  end

  def change_password
  end

  def update_password
    if @current_user&.authenticate(params[:current_password])
      if user_params[:password] == user_params[:password_confirmation] and @current_user.update_attribute(:password, user_params[:password])
        redirect_to change_password_teacher_me_path, notice: 'Senha atualizada com sucesso'
      else
        redirect_to change_password_teacher_me_path, alert: "Confirmação de Senha não está igual a Senha."
      end
    else
      redirect_to change_password_teacher_me_path, alert: 'Senha atual incorreta.'
    end
  end

  def remove_avatar
    @current_user.avatar.purge
    redirect_to(edit_profile_teacher_me_path, notice: 'Sua foto de perfil foi removida.')
  end

  private

  def user_params
    params.require(:teacher_user).permit(:first_name, :last_name, :email, :avatar, :whatsapp, :interests, :password, :password_confirmation, course_ids: [], college_ids: [])
  end

  def set_colleges
    @colleges = College.order(:name)
  end

  def set_courses
    @courses = Course.order(:name)
  end

end
