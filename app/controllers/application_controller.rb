class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user

  helper_method :current_user

  private

  def authenticate_user
    unless current_user
      redirect_to sign_in_path, alert: "Please sign in."
    end
  end

  def current_user
    @current_user ||= User.find_by_uuid(session[:user_uuid])
  end
end