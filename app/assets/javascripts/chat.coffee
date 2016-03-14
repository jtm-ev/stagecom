# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
getCookie = (name) ->
  re = new RegExp(name + '=([^;]+)')
  value = re.exec(document.cookie)
  if value != null then unescape(value[1]) else null

$ ->
  if (getCookie("user") != null)
    $('#user_field').val(getCookie("user"))
    $('#login').fadeOut 'slow'
    $(blurRadius: 10).animate { blurRadius: 0 },
      duration: 500
      easing: 'swing'
      step: ->
        $('#content').css
          '-webkit-filter': 'blur(' + @blurRadius + 'px)'
          'filter': 'blur(' + @blurRadius + 'px)'
        return
    return

$(document).on 'keypress', '[data-behavior~=username]', (event) ->
  if event.keyCode is 13
    document.cookie="user= " + event.target.value
    $ ->
      $(blurRadius: 10).animate { blurRadius: 0 },
        duration: 500
        easing: 'swing'
        step: ->
          $('#content').css
            '-webkit-filter': 'blur(' + @blurRadius + 'px)'
            'filter': 'blur(' + @blurRadius + 'px)'
          return
      return
    $('#login').fadeOut 'slow'
    location.reload()
