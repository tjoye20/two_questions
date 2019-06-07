class Requests::Update
  include Interactor

  before do 
    if context.request_id.blank? || context.request_state.blank?
      context.fail!(error: "Bad context in Requests::Update. Context: #{context}")
    end 
  end 

  def call
    context.request = Request.find(context.request_id)
    @old_request_state = context.request.state 

    context.request.update!(state: context.request_state)
  end 

  def rollback
    context.request.update(state: @old_request_state)
  end 
end 