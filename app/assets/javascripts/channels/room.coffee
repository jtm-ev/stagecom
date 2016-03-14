hasClass = (id, cls) ->
  el = document.getElementById(id)
  (' ' + el.className + ' ').indexOf(' ' + cls + ' ') > -1

toggle_class = (id, cls) ->
  if (hasClass(id, cls))
    $('#' + id).removeClass(cls)
  else
    $('#' + id).addClass(cls)
  return

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
    new_message = $('#messages').append(data['message'])
    if (data['user'] is getCookie('user'))
      $('#message:last-child').addClass('right floated')
    else
      $('#message:last-child').addClass('left floated')
    toggle_class('button_pyro', 'red') if data['buttons'] is "a"

  speak: (message, user, buttons)->
    @perform 'speak', message: message, user: user, buttons: buttons

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if (event.keyCode is 13 and event.target.value isnt "")
    App.room.speak event.target.value, getCookie("user")
    event.target.value = ''
    event.preventDefault()
  if (event.keyCode is 13 and event.target.value is "")
    event.target.value = ''
    event.preventDefault()

$ ->
  $("#button_pyro").on "click", ->
    if (hasClass("button_pyro", "red"))
      App.room.speak "Verstanden!", getCookie("user"), "a"
    else
      App.room.speak "Pyro scharf!", getCookie("user"), "a"
