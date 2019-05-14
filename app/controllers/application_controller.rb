class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user

  helper_method :current_user

  private

  def check_if_profile_and_questions_exist
    if !current_user.profile 
      redirect_to new_user_profile_path(current_user.uuid), alert: 'Please create your profile.'
    elsif current_user.profile.questions.empty?
      redirect_to new_profile_question_path(current_user.profile.uuid), alert: 'Please create your profile questions.'
    end
  end

  def authenticate_user
    unless current_user
      redirect_to sign_in_path, alert: "Please sign in."
    end
  end

  def current_user
    @current_user ||= User.includes(profile: :questions).find_by_uuid(session[:user_uuid])
  end
end