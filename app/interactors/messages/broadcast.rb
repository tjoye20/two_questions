class Messages::Broadcast
  include Interactor

  before do 
    if context.user_uuid.blank? || context.message_uuid.blank? || context.conversation_uuid.blank?
      context.fail!(error: "Bad context in Messages::Broadcast. Context: #{context}")
    end 
  end 

  def call
    BroadcastMessageJob.perform_later(context.user_uuid, context.message_uuid, context.conversation_uuid)
  end  
end 