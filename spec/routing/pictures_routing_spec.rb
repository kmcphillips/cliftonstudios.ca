require "spec_helper"

describe PicturesController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/pictures" }).to route_to(:controller => "pictures", :action => "index")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/pictures/1" }).to route_to(:controller => "pictures", :action => "show", :id => "1")
    end

  end
end
