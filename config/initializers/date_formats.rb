Time::DATE_FORMATS[:without_time] = lambda{ |time| time.strftime("%B #{time.day.ordinalize} %Y") }
Time::DATE_FORMATS[:with_time] = lambda{ |time| time.strftime("%B #{time.day.ordinalize} %Y at %I:%M%p") }
Time::DATE_FORMATS[:with_time_no_minutes] = lambda{ |time| hour = time.strftime("%I").gsub(/^0/, ""); time.strftime("%B #{time.day.ordinalize} %Y at #{hour} %p") }
Time::DATE_FORMATS[:index] = "%b %e/%Y %I:%M%p"
Time::DATE_FORMATS[:filename] = "%d-%m-%Y"

