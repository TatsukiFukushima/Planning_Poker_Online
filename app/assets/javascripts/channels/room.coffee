room_id = ->
  $('#messages').data('room_id')

room_ch = ->
  id = room_id()
  if id?
    return { channel: "RoomChannel", room_id: id }
  else
    return null

document.addEventListener 'turbolinks:request-start', ->
  if room_ch()?
    App.room.unsubscribe()

document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->

    disconnected: ->
      this.perform('unsubscribed')

    received: (data) ->
      $('#messages').append data['message']

    speak: (message) ->
      @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode == 13 && event.shiftKey
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()
