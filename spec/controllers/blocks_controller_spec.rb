require 'spec_helper'

describe BlocksController do

  describe "GET about" do
    it "assigns the requested block as @block" do
      about = mock :about
      availability = mock :availability
      executive = mock :executive
      Block.should_receive(:find_by_label).with("about").and_return(about)
      Block.should_receive(:find_by_label).with("availability").and_return(availability)
      Executive.should_receive(:filled).and_return(executive)
      executive.should_receive(:sorted).and_return(executive)
      get :about
      assigns(:about).should eq(about)
      assigns(:availability).should eq(availability)
      assigns(:executive).should eq(executive)
    end
  end

  describe "GET links" do
    it "assigns the requested block as @block" do
      links = ["links"]
      Block.stub(:find_by_label).with("links")
      Link.should_receive(:sorted).and_return(links)
      get :links
      assigns(:block).should be(nil)
      assigns(:links).should eq(links)
      assigns(:title).should eq("Links")
    end
  end

  describe "GET contact" do
    it "should render the default template" do
      get :contact
      response.should render_template(:contact)
    end

    it "should find the block" do
      availability = mock :availability
      contact = mock :contact
      Block.should_receive(:find_by_label).with("availability").and_return(availability)
      Block.should_receive(:find_by_label).with("contact").and_return(contact)
      get :contact
      assigns(:availability).should eq(availability)
      assigns(:block).should eq(contact)
    end
  end

  describe "GET search" do
    it "should just redirect to google" do
      get :search, search: "pie"
      response.should redirect_to("http://www.google.ca/search?q=site%3Acliftonstudios.ca+pie")
    end
  end

end
