require 'spec_helper'

describe PicturesController do

  def mock_picture(stubs={})
    (@mock_picture ||= mock_model(Picture).as_null_object).tap do |picture|
      picture.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all pictures as @pictures" do
      Picture.stub(:all) { [mock_picture] }
      get :index
      assigns(:pictures).should eq([mock_picture])
    end
  end

  describe "GET show" do
    it "assigns the requested picture as @picture" do
      Picture.stub(:find).with("37") { mock_picture }
      get :show, :id => "37"
      assigns(:picture).should be(mock_picture)
    end
  end

end
