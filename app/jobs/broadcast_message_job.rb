class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(user_uuid, message_uuid, conversation_uuid)
    message = Message.find_by_uuid(message_uuid)

    payload = {
      conversation_uuid: conversation_uuid,
      content: message.body,
      sender: user_uuid
    }
    
    ActionCable.server.broadcast("conversation-#{conversation_uuid}", message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'conversations/message', locals: { message: message })
  end
end
