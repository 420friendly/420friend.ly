class VerifyAge
  constructor: ->
    @add_verify_binding()

  add_verify_binding: ->
    $('#verify-age .verify').click (ev) =>
      ev.preventDefault()
      @save_verified_cookie()
      $('html').addClass 'age-verified'

  save_verified_cookie: ->
    expires = new Date()
    expires.setTime expires.getTime() + (365 * 24 * 60 * 60 * 1000)

    document.cookie = 'ageVerified=yes;expires=' + expires.toUTCString() +
      ';path=/';

$(document).ready -> new VerifyAge