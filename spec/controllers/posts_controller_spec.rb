require 'spec_helper'

describe PostsController do

  def mock_post(stubs={})
    (@mock_post ||= mock_model(Post).as_null_object).tap do |post|
      allow(post).to receive(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      sorted_mock = double :sorted
      allow(sorted_mock).to receive(:paginate) { [mock_post] }
      allow(Post).to receive(:sorted).and_return(sorted_mock)
      get :index
      expect(assigns(:posts)).to eq([mock_post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      allow(Post).to receive(:find_by_permalink).with("37") { mock_post }
      get :show, :id => "37"
      expect(assigns(:post)).to be(mock_post)
    end
  end

end
