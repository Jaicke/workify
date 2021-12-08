class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

  def record_not_found_error
    redirect_to request.referrer, alert: 'Você não tem acesso a esse item'
  end
end
