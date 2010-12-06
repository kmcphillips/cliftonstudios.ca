require 'spec_helper'

describe ApplicationHelper do
  include ApplicationHelper

  describe "page_title" do
    it "should generate the default title" do
      stub!(:params).and_return({})
      page_title.should == "Clifton Studios"
    end
    
    it "should generate the page title with an @title" do
      stub!(:params).and_return({})
      instance_variable_set('@title', "Pie")
      page_title.should == "Clifton Studios :: Pie"
    end
    
    it "should know the members area" do
      stub!(:params).and_return(:controller => "members_area/pie")
      page_title.should == "Clifton Studios :: Members Area"
    end
    
    it "should handle the blocks controller" do
      stub!(:params).and_return(:controller => "blocks", :action => "cake")
      page_title.should == "Clifton Studios :: Cake"
    end
    
    it "should handle the most complex case" do
      stub!(:params).and_return(:controller => "members_area/pie")
      instance_variable_set('@title', "Delicious")
      page_title.should == "Clifton Studios :: Members Area :: Delicious"
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
  
  describe "custom routes" do
    it "should generate post_path" do
      post = mock_model(Post, :permalink => "pie")
      post_path(post).should == "/news/#{post.permalink}"
    end
    
    it "should generate posts_path" do
      posts_path.should == "/"
    end
    
    it "should generate members_path" do
      should_receive(:artists_path).with(no_args).and_return("pie")
      members_path.should == "pie"
    end
    
    it "should generate member_path" do
      member = mock_model(Member, :to_param => "delicious")
      should_receive(:artists_path).with("delicious").and_return("pie")
      member_path(member).should == "pie"
    end
  end

end

