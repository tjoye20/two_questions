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
   @questions = Question.includes(:responses).where(responses: { user_id: @user.id })
  end 

  private

  def set_user
    @user = User.find_by_uuid(params[:id])
  end 
end