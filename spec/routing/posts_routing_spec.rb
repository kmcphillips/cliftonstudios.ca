require "spec_helper"

describe PostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/" }.should route_to(:controller => "posts", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/news/1" }.should route_to(:controller => "posts", :action => "show", :id => "1")
    end

  end
end
