class Requests::CreateResponse
  include Interactor

  before do 
    if context.response_params.blank? || context.user_id.blank?
      context.fail!(error: "Bad context in Requests::CreateResponse. Context: #{context}")
    end 
  end 

  def call
    begin 
      Response.create_question_responses(context.response_params.merge({user_id: context.user_id}))
    rescue ActiveRecord::RecordInvalid => e 
      context.fail!(error: e.message)
    end 
  end 
end 