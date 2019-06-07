class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(user_uuid, message_uuid, conversation_uuid)
    message = Message.find_by_uuid(message_uuid)

    payload = {
      conversation_uuid: conversation_uuid,
      message: render_message(message, user_uuid),
      sender: user_uuid
    }
    
    ActionCable.server.broadcast('conversations', payload)
  end

  private

  def render_message(message, user_uuid)
    ApplicationController.renderer.render(partial: 'conversations/message', locals: { message: message, current_user: User.find_by_uuid(user_uuid) })
  end
end
