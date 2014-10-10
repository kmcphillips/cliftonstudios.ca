$ ->
  setupLoginFocus()
  setupDatepickers()
  setupLightbox()
  setupSortableTables()
  setupRentingSelects()

setupLoginFocus = ->
  if $('#login_email').val()? && $('#login_email').val()?.length > 0
    $('#login_password').focus()
  else if $('#login_email').val()?
    $('#login_email').focus()

setupLightbox = ->
  $("a.thumb").fancybox
    transitionIn: "elastic"
    transitionOut: "elastic"
    speedIn: 200
    speedOut: 200
    titlePosition: "inside"
    overlayOpacity: 0.3
    overlayColor: "#666"
    cyclic: true
    hideOnContentClick: true

setupDatepickers = ->
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"

  $(".datetimepicker").datepicker
    ampm: true
    stepMinute: 15

setupSortableTables = ->
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

      stripeTable(this, "sortable_row")

    ).disableSelection()

setupRentingSelects = ->
  if $("#renting_select")
    updateRentingSelects()

    $("#renting_select").change ->
      updateRentingSelects()

stripeTable = (table, klass) ->
  finder = "tr"
  finder = finder + "." + klass if klass?

  $(table).find(finder).each (index, element) ->
    $(element).removeClass "odd even"

    if index % 2 is 0
      $(element).addClass "odd"
    else
      $(element).addClass "even"

updateRentingSelects = ->
  if $("#renting_select").val() == "true"
    $("#subletting_member_fields").hide()
    $("#dependent_members").show()
    $("#subletting_member").val("")
  else
    $("#subletting_member_fields").show()
    $("#dependent_members").hide()
