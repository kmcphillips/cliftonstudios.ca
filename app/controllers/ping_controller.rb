class PingController < ApplicationController
  def index
    ActiveRecord::Base.connection.execute("SELECT 1").to_a.first && render(text: "OK")
  end
end
