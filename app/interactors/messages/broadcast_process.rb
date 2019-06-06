class Messages::BroadcastProcess
  include Interactor::Organizer

  before do 
    if [context.message, context.user_uuid, context.conversation_uuid ].any?(&:blank?)
      context.fail!(error: "Bad context in Messages::BroadcastProcess. Context: #{context}")
    end 
  end 

  organize Messages::Create,
           Messages::Broadcast

end 