class RequestsController < ApplicationController

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

  private

  def response_params
    params.permit(:question1_id, :response1, :question2_id, :response2, :profile_id)
  end 
end 