require "spec_helper"

describe BlocksController do
  describe "routing" do

    it "recognizes and generates #about" do
      expect({ :get => "/about" }).to route_to(:controller => "blocks", :action => "about")
    end

    it "recognizes and generates #links" do
      expect({ :get => "/links" }).to route_to(:controller => "blocks", :action => "links")
    end

  end
end
