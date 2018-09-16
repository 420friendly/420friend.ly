class @LiveStreamDialog
  scope = '#live-stream-dialog'

  constructor: ->
    @add_close_binding()

  add_close_binding: ->
    $('.close', scope).click (ev) =>
      ev.preventDefault()
      LiveStreamDialog.hide()

    $(scope).click (ev) =>
      ev.preventDefault()
      LiveStreamDialog.hide()

    $('.live-stream', scope).click => false

  @hide: -> $(scope).hide()

  @show: -> $(scope).show()

$(document).ready -> new LiveStreamDialog