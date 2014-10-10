$ ->
  loginFocus()

loginFocus = ->
  if $('#login_email').val()? && $('#login_email').val()?.length > 0
    $('#login_password').focus()
  else if $('#login_email').val()?
    $('#login_email').focus()
