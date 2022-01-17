class Student::BaseController < ApplicationController
  layout 'student'

  before_action :authenticate
  before_action :verify_user_profile
  before_action :fetch_menu_notifications

  private

  def current_user
    @current_user ||= Student::User.find(session[:student_user_id]) if session[:student_user_id]
  rescue ActiveRecord::RecordNotFound
    session[:student_user_id] = nil
    redirect_to sign_in_path
  end
  helper_method :current_user

  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?

  def authenticate
    redirect_to sign_in_path unless logged_in?
  end

  def verify_user_profile
    unless @current_user&.profile_completed?
      redirect_to edit_profile_student_me_path, alert: 'Complete seu perfil para continuar navegando'
    end
  end

  def fetch_menu_notifications
    @menu_notifications = @current_user.notifications.order(read: :asc, created_at: :desc).first(5)
  end

end
