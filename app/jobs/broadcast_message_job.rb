class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(user_uuid, message_uuid, conversation_uuid)
    payload = {
      conversation_uuid: conversation_uuid,
      content: Message.find_by_uuid(message_uuid).body,
      sender: user_uuid
    }
    
    ActionCable.server.broadcast("conversation-#{conversation_uuid}", payload)
  end
end
