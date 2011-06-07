class UnsubscribeController < ApplicationController

  def new
    @member = Member.find_by_email_and_secret_hash(params[:email], params[:key])
  end

  def update
    @member = Member.find_by_email_and_secret_hash(params[:email], params[:key])
  end

end
