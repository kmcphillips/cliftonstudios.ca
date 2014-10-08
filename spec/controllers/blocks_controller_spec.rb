require 'spec_helper'

describe BlocksController do

  describe "GET about" do
    it "assigns the requested block as @block" do
      about = double :about
      availability = double :availability
      executive = double :executive
      expect(Block).to receive(:find_by_label).with("about").and_return(about)
      expect(Block).to receive(:find_by_label).with("availability").and_return(availability)
      expect(Executive).to receive(:filled).and_return(executive)
      expect(executive).to receive(:sorted).and_return(executive)
      get :about
      expect(assigns(:about)).to eq(about)
      expect(assigns(:availability)).to eq(availability)
      expect(assigns(:executive)).to eq(executive)
    end
  end

  describe "GET links" do
    it "assigns the requested block as @block" do
      links = ["links"]
      allow(Block).to receive(:find_by_label).with("links")
      expect(Link).to receive(:sorted).and_return(links)
      get :links
      expect(assigns(:block)).to be(nil)
      expect(assigns(:links)).to eq(links)
      expect(assigns(:title)).to eq("Links")
    end
  end

  describe "GET contact" do
    it "should render the default template" do
      get :contact
      expect(response).to render_template(:contact)
    end

    it "should find the block" do
      availability = double :availability
      contact = double :contact
      expect(Block).to receive(:find_by_label).with("availability").and_return(availability)
      expect(Block).to receive(:find_by_label).with("contact").and_return(contact)
      get :contact
      expect(assigns(:availability)).to eq(availability)
      expect(assigns(:block)).to eq(contact)
    end
  end

  describe "GET search" do
    it "should just redirect to google" do
      get :search, search: "pie"
      expect(response).to redirect_to("http://www.google.ca/search?q=site%3Acliftonstudios.ca+pie")
    end
  end

end
