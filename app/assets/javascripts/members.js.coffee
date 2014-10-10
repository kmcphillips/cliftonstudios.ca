window.preview_link = (id) ->
  link = $(id).val()

  if link.match(/^http(s)?:\/\/.+/)
    window.open(link)
  else
    alert "URL must be valid and begin with 'http://' or 'https://'"

  false

window.stripe_table = (table, klass) ->
  finder = "tr"
  finder = finder + "." + klass  if klass?

  $(table).find(finder).each (index, element) ->
    $(element).removeClass "odd even"

    if index % 2 is 0
      $(element).addClass "odd"
    else
      $(element).addClass "even"

window.convert_datetime_select = (finder) ->
  year = 0
  month = 0
  day = 0

  $(finder).each ->
    $(this).find("select").each (index, select) ->
      switch index
        when 0 # year
          year = $(select).val()
          $(select).hide()
        when 1 # month
          month = $(select).val()
          $(select).hide()
        when 2 # day
          day = $(select).val()
          $(select).hide()
        when 3 # hour
          selected = $(select).val()
          $(select).children().remove()
          i = 0
          while i <= 23
            if i is 0
              text = "AM 12"
            else if i < 12
              text = "AM " + i
            else if i is 12
              text = "PM 12"
            else
              text = "PM " + (i - 12)
            $(select).append "<option value='" + i + "' " + ((if selected is i then "selected='selected'" else "")) + ">" + text + "</option>"
            i++
        when 4 # minute
          $(select).find("option").each ->
            $(this).remove() if $(this).val() isnt "00" and $(this).val() isnt "15" and $(this).val() isnt "30" and $(this).val() isnt "45"

    $(this).prepend "<input type='text' size='10' class='datetime_picker' value='" + year + "/" + month + "/" + day + "' />"

    $(this).find("input[type=text]").datepicker
      changeMonth: true
      changeYear: true
      dateFormat: "yy/mm/dd"
      onClose: (text) ->
        tokens = text.split("/")
        i = 0
        while i <= 2
          $($(finder).find("select")[i]).val tokens[i].replace(/^[0]/g, "")
          i++

$ ->
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"

  $(".datetimepicker").datepicker
    ampm: true
    stepMinute: 15

  window.convert_datetime_select "ul.form .datetime"
