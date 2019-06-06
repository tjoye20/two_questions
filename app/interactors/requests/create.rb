class Requests::Create
  include Interactor

  before do 
    if context.user_id.blank? || context.profile_id.blank?
      context.fail!(error: "Bad context in Requests::Create. Context: #{context}")
    end 
  end 

  def call
    context.request = Request.new(user_id: context.user_id, profile_id: context.profile_id) 
    
    unless context.request.save
      context.fail!(error: 'Bad context in Requests::Create. Failed to create requests. Errors: ' + context.request.errors.join(', '))
    end
  end 

  def rollback
    context.request.destroy
  end 
end 