class Requests::CreateResponse
  include Interactor

  before do 
    if context.response_params.blank? || context.user_id.blank?
      context.fail!(error: "Bad context in Requests::CreateResponse. Context: #{context}")
    end 

    check_if_response_exists
  end 

  def call
    begin 
      Response.create!(user_id: context.user_id, question_id: context.response_params[:question1_id], body: context.response_params[:response1])
      Response.create!(user_id: context.user_id, question_id: context.response_params[:question2_id], body: context.response_params[:response2])
    rescue ActiveRecord::RecordInvalid => e 
      context.fail!(error: e.message)
    end 
  end 

  def check_if_response_exists
    unless Response.where(user_id: context.user_id, question_id: [context.response_params[:question1_id], context.response_params[:question2_id]]).empty?
      context.fail!(error: 'You already submitted responses for this profile.')
    end 
  end 
end 