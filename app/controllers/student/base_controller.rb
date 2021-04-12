class Student::BaseController < ApplicationController
  layout 'student'

  before_action :authenticate

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
end
