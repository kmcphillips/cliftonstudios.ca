require "spec_helper"

describe PicturesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/pictures" }.should route_to(:controller => "pictures", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/pictures/1" }.should route_to(:controller => "pictures", :action => "show", :id => "1")
    end

  end
end
