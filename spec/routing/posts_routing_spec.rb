require "spec_helper"

describe PostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/" }).to route_to(:controller => "posts", :action => "index")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/news/1" }).to route_to(:controller => "posts", :action => "show", :id => "1")
    end

    it "recognizes and generates #rss" do
      expect({ :get => "/rss.xml" }).to route_to(:controller => "posts", :action => "rss", :format => "xml")
    end

  end
end
