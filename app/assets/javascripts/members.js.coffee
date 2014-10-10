$ ->
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"

  $(".datetimepicker").datepicker
    ampm: true
    stepMinute: 15


window.preview_link = (id) ->
  link = $(id).val()

  if link.match(/^http(s)?:\/\/.+/)
    window.open(link)
  else
    alert "URL must be valid and begin with 'http://' or 'https://'"

  false

window.stripe_table = (table, klass) ->
  finder = "tr"
  finder = finder + "." + klass if klass?

  $(table).find(finder).each (index, element) ->
    $(element).removeClass "odd even"

    if index % 2 is 0
      $(element).addClass "odd"
    else
      $(element).addClass "even"
