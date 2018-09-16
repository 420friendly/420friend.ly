class Sidebar
  scope = '#sidebar'

  constructor: ->
    @add_live_stream_binding()

  add_live_stream_binding: ->
    $('.live-stream', scope).click (ev) =>
      ev.preventDefault()
      LiveStreamDialog.show()

$(document).ready -> new Sidebar