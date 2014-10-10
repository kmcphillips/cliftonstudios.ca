$ ->
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"

  $(".datetimepicker").datepicker
    ampm: true
    stepMinute: 15

  if $("#renting_select")
    update_renting_fields()

    $("#renting_select").change ->
      update_renting_fields()

  if $("#sortable_table")
    $("#sortable_table tbody").sortable(update: ->
      data = ""

      $("#sortable_table tbody tr").each ->
        val = $(this).attr("data-link-id")
        data += "link[]=" + val + "&"  if val?

      $.ajax
        url: "/members/links/sort"
        type: "post"
        data: data
        error: ->
          alert "There was an error sorting links. Contact administrator."

      stripe_table(this, "sortable_row")

    ).disableSelection()


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

update_renting_fields = ->
  if $("#renting_select").val() == "true"
    $("#subletting_member_fields").hide()
    $("#dependent_members").show()
    $("#subletting_member").val("")
  else
    $("#subletting_member_fields").show()
    $("#dependent_members").hide()
