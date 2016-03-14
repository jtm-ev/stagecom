getCookie = (name) ->
  re = new RegExp(name + '=([^;]+)')
  value = re.exec(document.cookie)
  if value != null then unescape(value[1]) else null

App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#message_container").animate({ scrollTop: $("#message_container")[0].scrollHeight }, "slow");
    $('#messages').append data['message']

  speak: (message, user, buttons)->
    @perform 'speak', message: message, user: user, buttons: buttons

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak event.target.value, getCookie("user")
    event.target.value = ''
    event.preventDefault()
