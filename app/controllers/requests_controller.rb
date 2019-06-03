class RequestsController < ApplicationController
  before_action :set_request, only: :update
  before_action :set_request_user, only: :show
  before_action :set_profile, only: :update 

  def index
    user_response_ids = current_user.requests.pluck(:user_id)
    @users = User.where(id: user_response_ids)

    if @users.empty?
      flash[:notice] = 'You do not have any responses right now.'
      redirect_back(fallback_location: root_path)
    end 
  end 

  def show
    @request = Request.includes(:questions, :responses).where(
                requests: { profile_id: current_user.profile.id }, 
                responses: { user_id: @request_user.id }
              )&.first
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
    @request.update(state: requests_param[:state])

    if requests_param[:state] == 'approved'
      redirect_to profile_path(@profile.uuid), notice: 'Approved! Now submit your responses to their questions.'
    else
      redirect_to requests_path, notice: 'Rejected.'
    end 
  end 

  private

  def set_request_user
    @request_user = User.find_by_uuid(params[:id])
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