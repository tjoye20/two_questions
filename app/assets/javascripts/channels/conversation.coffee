App.conversation = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#' + data['conversation_uuid']).append(data['message'])

  speak: (user_uuid, conversation_uuid, message) ->
    @perform 'speak', user_uuid: user_uuid, conversation_uuid: conversation_uuid, message: message