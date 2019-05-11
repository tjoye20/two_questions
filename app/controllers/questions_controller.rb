class QuestionsController < ApplicationController
  before_action :set_profile
  before_action :set_questions, only: :new

  def create
    question = @profile.questions.new(question_params)

    if question.save
      redirect_to new_profile_questions_path(@profile.uuid), notice: 'Question successfully saved.'
    else
      render_error_view
    end 
  end 

  def destroy
    question = @profile.questions.find_by_uuid(params[:id])
    
    if question.archive
      redirect_to root_path, notice: 'Question has been archived.'
    else
      render_error_view
    end 
  end 

  private

  def render_error_view
    flash[:alert] = question.error
    redirect_back(fallback_location: root_path)
  end 

  def set_profile
   @profile = Profile.find_by_uuid(params[:uuid])
  end 

  def set_questions
    @questions = @profile.questions
  end 

  def question_params
    params.require(:question).permit(:body)
  end 
end