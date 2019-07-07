class RequestsController < ApplicationController
  before_action :set_request, only: :update
  before_action :set_request_user, only: :show
  before_action :set_profile, only: :update 

  def index
    user_response_ids = current_user.requests.pluck(:user_id)
    @users = User.where(id: user_response_ids)

    if @users.empty?
      flash[:alert] = 'You do not have any requests right now.'
      redirect_back(fallback_location: root_path)
    end 
  end 

  def show
    @request = Request.includes(:questions, :responses).where(
                requests: { profile_id: current_user.profile.id }, 
                responses: { user_id: @request_user.id }
              )&.first

    if @request
      @request.read
    else
      flash[:alert] = 'That request does not exist.'
      redirect_back(fallback_location: root_path)
    end 
end 

  def create
    result = Requests::CreateProcess.call\
              user_id: current_user.id, 
              response_params: response_params,
              profile_id: response_params[:profile_id]

    if result.success?
      redirect_to profiles_path, notice: 'Responses submitted.'
    else
      flash[:alert] = result.error
      redirect_back(fallback_location: root_path)
    end 
  end 

  def update
    #Someone creates a request for your PROFILE, so THEY are the USER. 
    #You/profile_id are the one making the Requests#Update call.
    
    result = Requests::UpdateProcess.call(request_id: @request.id, request_state: requests_param[:state])
    
    if result.success?
      redirect_to result.redirect_path, notice: result.notice
    else
      flash[:alert] = result.error
      redirect_back(fallback_location: root_path)
    end 
  end 

  private

  def set_request_user
    @request_user = User.includes(:profile).find_by_uuid(params[:id])
  end 

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end 

  def set_request
    @request = current_user.requests.find_by_uuid(params[:id])
  end 

  def requests_param
    params.permit(:state)
  end 

  def response_params
    params.permit(:question1_id, :response1, :question2_id, :response2, :profile_id)
  end 
end 