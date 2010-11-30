class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :page_title

end

