class Messages::Create
  include Interactor

  before do 
    if context.user_uuid.blank? || context.message.blank? || context.conversation_uuid.blank?
      context.fail!(error: "Bad context in Messages::Create. Context: #{context}")
    end 
  end 

  def call
    context.user_id = User.find_by_uuid(context.user_uuid).id 
    context.conversation_id = Conversation.find_by_uuid(context.conversation_uuid).id

    @message = Message.new(user_id: context.user_id, conversation_id: context.conversation_id, body: context.message) 
    
    unless @message.save
      context.fail!(error: 'Bad context in Messages::Create. Failed to create message. Errors: ' + @message.errors.join(', '))
    else
      context.message_uuid = @message.uuid
    end 
  end 

  def rollback
    @message.destroy
  end 
end 