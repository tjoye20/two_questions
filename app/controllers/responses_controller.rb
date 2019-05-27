class ResponsesController < ApplicationController
  before_action :set_user, only: :show

  def index
    user_response_ids = current_user.questions.first.responses.pluck(:user_id)
    @users = User.where(id: user_response_ids)

    if @users.empty?
      flash[:notice] = 'You do not have any responses right now.'
      redirect_back(fallback_location: root_path)
    end 
  end 

  def show

  end 

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

  def set_user
    @user = User.find_by_uuid(params[:id])
  end 

  def response_params
    params.permit(:question1_id, :response1, :question2_id, :response2)
  end 
end