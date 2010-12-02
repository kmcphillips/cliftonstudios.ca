require 'spec_helper'

describe BlocksController do

  def mock_block(stubs={})
    @mock_block ||= mock_model(Block, stubs).as_null_object
  end
  
  describe "GET about" do
    it "assigns the requested block as @block" do
      another_mock_block = mock_model(Block)
      Block.stub(:find_by_label).with("about") { mock_block }
      Block.stub(:find_by_label).with("availability") { another_mock_block }
      get "about"
      assigns(:about).should be(mock_block)
      assigns(:availability).should be(another_mock_block)
    end
  end

  describe "GET links" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("links")
      Link.should_receive(:order).with("created_at ASC").and_return(["links"])
      get "links"
      assigns(:block).should be(nil)
      assigns(:links).should == ["links"]
    end
  end

end
