window.preview_link = (id) ->
  link = $(id).val()

  if link.match(/^http(s)?:\/\/.+/)
    window.open(link)
  else
    alert "URL must be valid and begin with 'http://' or 'https://'"

  false
