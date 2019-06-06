class Messages::Broadcast
  include Interactor

  before do 
    if context.user_id.blank? || context.message_id.blank? || context.conversation_id.blank?
      context.fail!(error: "Bad context in Messages::Broadcast. Context: #{context}")
    end 
  end 

  def call
    BroadcastMessageJob.perform_later(context.user_id, context.message_id, context.conversation_id)
  end  
end 