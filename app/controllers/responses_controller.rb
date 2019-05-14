class ResponsesController < ApplicationController
  def create
    begin
      Response.create_question_responses(response_params.merge({user_id: current_user.id}))
      redirect_to profiles_path, notice: 'Responses submitted.'
    rescue ActiveRecord::RecordInvalid => e 
      flash[:alert] = "#{e.message}"
      redirect_back(fallback_location: root_path)
    end 
  end

  private

  def response_params
    params.permit(:question1_id, :response1, :question2_id, :response2)
  end 
end