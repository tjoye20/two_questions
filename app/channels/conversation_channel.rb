class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from("conversations") 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Messages::BroadcastProcess.call(message: data['message'], user_uuid: data['user_uuid'] ,conversation_uuid: data[
      'conversation_uuid'])
  end
end
