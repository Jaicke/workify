class Student::PasswordResetsController < ApplicationController
  layout 'sign'

  def new
  end

  def create
    @user = Student::User.find_by(email: params[:email])

    respond_to do |format|
      if @user.present?
        @valid_email = true
        Student::UserMailer.with(user: @user).password_reset_email.deliver_later

        format.js
      else
        @valid_email = false
        format.js
      end
    end
  end

  def edit
    @user = Student::User.find_by(reset_password_token: params[:token])

    if @user.blank? || !@user.password_token_valid?
      redirect_to sign_in_path, alert: 'Redefinição de senha expirada.'
    end
  end

  def update
    @user = Student::User.find_by(reset_password_token: params[:token])

    respond_to do |format|
      if @user.reset_password_sent_at < 4.hours.ago
        @valid_token =  false
        format.js
      elsif user_params[:password] == user_params[:password_confirmation] and @user.update_attribute(:password, user_params[:password])
        @valid_token = true
        format.js
      else
        format.js
      end
    end
  end

  private

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
