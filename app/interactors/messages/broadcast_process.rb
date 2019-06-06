class Messages::BroadcastProcess
  include Interactor::Organizer

  before do 
    if [context.response_params, context.user_id, context.profile_id ].any?(&:blank?)
      context.fail!(error: "Bad context in Messages::BroadcastProcess. Context: #{context}")
    end 
  end 

  organize Messages::Create,
           Requests::Broadcast

end 