class LiveStream
  delay = 60
  image_interval = 15
  image_url_base = 'https://live.420friend.ly/thumb/'
  live_after = 2
  live_before = 14
  max_retries = 2

  constructor: ->
    @$live_stream = $('.live-stream')
    @load()

  go_offline: -> @$live_stream.removeClass('live')

  go_live: (url) ->
    @$live_stream.css('background-image', 'url(' + url + ')')
      .removeClass('sleeping').addClass('live')

  go_to_sleep: ->
    return if @sleeping()

    @set_updated_at()
    @$live_stream.removeClass('live').addClass('sleeping')

  image_url: ->
    year = @date.getUTCFullYear()
    month = @date.getUTCMonth() + 1
    day = @date.getUTCDate()
    hour = @date.getUTCHours()
    minute = @date.getMinutes()
    version = Math.floor(@date.getSeconds() / image_interval) + 1

    if month < 10 then month = "0" + month
    if day < 10 then day = "0" + day
    if hour < 10 then hour = "0" + hour
    if minute < 10 then minute = "0" + minute

    image_url_base + year + month + day + hour + minute + '-' + version + '.jpg'

  load: ->
    @date = new Date();
    @date.setSeconds(@date.getSeconds() - delay)

    if @date.getUTCHours() >= live_after && @date.getUTCHours() < live_before
      @load_live()
    else
      @go_to_sleep()

    setTimeout =>
      @load()
    , image_interval * 1000

  load_live: (retry = 0) ->
    @date.setSeconds(@date.getSeconds() - retry * image_interval) if retry > 0

    url = @image_url()

    $('<img />').attr('src', url).on 'load', =>
      @go_live(url)
    .on 'error', =>
      if retry < max_retries then @load_live(retry + 1) else @go_offline()

  sleeping: -> @$live_stream.hasClass('sleeping')

  set_updated_at: ->
    $.get image_url_base + 'last.jpg', (ev, status, xhr) =>
      date = new Date xhr.getResponseHeader('Last-Modified')
      hour = date.getHours()
      minute = date.getMinutes()

      meridium = if hour >=12 then 'PM' else 'AM'

      if hour == 0
        hour = 12
      else if hour > 12
        hour = hour % 12

      if minute < 10 then minute = "0" + minute

      date_str = (date.getMonth() + 1) + '/' + date.getDate() + ' ' +
        hour + ':' + minute + meridium

      @$live_stream.attr('updated-at', date_str)

$(document).ready -> new LiveStream