App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
   $('#messages').append data['message']
    # Called when there's incoming data on the websocket for this channel

  speak: (message) ->
    @perform 'speak', message: message
    
    $(document).on 'keypress', '[data-behavior~=message_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.message.speak event.target.value
    event.target.value = ''
    event.preventDefault()
