require "spec_helper"

describe EventsController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/events" }).to route_to(:controller => "events", :action => "index")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/events/1" }).to route_to(:controller => "events", :action => "show", :id => "1")
    end

  end
end
