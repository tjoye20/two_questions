class QuestionsController < ApplicationController
  before_action :set_profile
  before_action :keep_user_from_creating_new_questions, only: :new

  def create
    @profile.create_questions(question_params)

    if @profile.questions.present?
      redirect_to profiles_path, notice: 'Questions successfully saved.'
    else    
      flash[:alert] = 'Questions not successfully saved. Please try again.'
      redirect_back(fallback_location: root_path)
    end 
  end 

  private

  def keep_user_from_creating_new_questions
    unless @profile.questions.empty?
      redirect_to profiles_path
    end
  end 

  def set_profile
   @profile = current_user.profile
  end 

  def question_params
    params.permit(:question1, :question2)
  end 
end