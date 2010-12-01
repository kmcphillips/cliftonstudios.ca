require "spec_helper"

describe ArtistsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/artists" }.should route_to(:controller => "artists", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/artists/1" }.should route_to(:controller => "artists", :action => "show", :id => "1")
    end

  end
end
