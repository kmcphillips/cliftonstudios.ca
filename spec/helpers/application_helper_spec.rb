require 'spec_helper'

describe ApplicationHelper do
  include ApplicationHelper

  describe "page_title" do
    it "should generate the default title" do
      page_title.should == "Clifton Studios"
    end
  end
  
  describe "error messages" do
    it "should render the partial" do
      obj = mock :object
      should_receive(:render).with(:partial => "/shared/error_messages", :object => obj)
      error_messages(obj)
    end
  end

  describe "members_area?" do
    it "should know if it is not members area" do
      stub!(:params => {:controller => "posts"})
      members_area?.should be_false
    end

    it "should know if it is members area" do
      stub!(:params => {:controller => "members_area/posts"})
      members_area?.should be_true
    end
  end

  describe "image link helpers" do
    it "should be tested" do
      pending "new/edit/delete/index icon helpers"
    end
  end

end

