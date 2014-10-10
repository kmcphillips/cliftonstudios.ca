$(document).ready(function(){
  $('.datepicker').datepicker({
    dateFormat: "yy-mm-dd"
  });

  $('.datetimepicker').datepicker({
    ampm: true,
    stepMinute: 15
  });

  convert_datetime_select("ul.form .datetime");
});


function preview_link(id)
{
  if(!$(id).val().match(/^http(s)?:\/\/.+/))
    alert("URL must be valid and begin with 'http://' or 'https://'");
  else
    window.open($(id).val());

  return false;
}

function stripe_table(table, klass)
{
  var finder = "tr";
  if(klass != undefined)
    finder = finder + "." + klass;

  $(table).find(finder).each(function(index, element) {
    $(element).removeClass("odd even");

    if(index % 2 == 0)
      $(element).addClass("even");
    else
      $(element).addClass("odd");
  });
}

function convert_datetime_select(finder)
{
    year = 0;
    month = 0;
    day = 0;

    $(finder).each(function(){
      $(this).find("select").each(function(index, select){
          switch(index)
          {
              case 0: // year
                  year = $(select).val();
                  $(select).hide();
                  break;
              case 1: // month
                  month = $(select).val();
                  $(select).hide();
                  break;
              case 2: // day
                  day = $(select).val();
                  $(select).hide();
                  break;
              case 3: // hour
                  selected = $(select).val();
                  $(select).children().remove()
                  for(i = 0; i <= 23; i++)
                  {
                      if(i == 0)
                          text = "AM 12"
                      else if(i < 12)
                          text = "AM " + i
                      else if(i == 12)
                          text = "PM 12"
                      else
                          text = "PM " + (i - 12)

                      $(select).append("<option value='" + i + "' " + (selected == i ? "selected='selected'" : "") + ">" + text + "</option>")
                  }
                  break;
              case 4: // minute
                  $(select).find("option").each(function(){
                      if($(this).val() != "00" && $(this).val() != "15" && $(this).val() != "30" && $(this).val() != "45")
                          $(this).remove();
                  });
          }
      });

      $(this).prepend("<input type='text' size='10' class='datetime_picker' value='" + year + "/" + month + "/" + day + "' />");
      $(this).find("input[type=text]").datepicker({
          changeMonth: true,
          changeYear: true,
          dateFormat: "yy/mm/dd",
          onClose: function(text) {
              tokens = text.split("/");
              for(i = 0; i <= 2; i++)
              {
                  $($(finder).find("select")[i]).val(tokens[i].replace(/^[0]/g,""));
              }
          }
      });
    });
}


