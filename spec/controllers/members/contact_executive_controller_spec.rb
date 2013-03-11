require 'spec_helper'

describe Members::ContactExecutiveController do

  before(:each) do
    member_login
  end

  describe "GET index" do
    it "should be successful" do
      get :index
      response.should render_template(:index)
    end
  end

end
