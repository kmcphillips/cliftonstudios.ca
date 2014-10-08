require "spec_helper"

describe ArtistsController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/artists" }).to route_to(:controller => "artists", :action => "index")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/artists/1" }).to route_to(:controller => "artists", :action => "show", :id => "1")
    end

  end
end
