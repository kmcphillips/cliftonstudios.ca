require 'spec_helper'

describe PostsController do

  def mock_post(stubs={})
    (@mock_post ||= mock_model(Post).as_null_object).tap do |post|
      post.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      sorted_mock = mock :sorted
      sorted_mock.stub(:paginate) { [mock_post] }
      Post.stub(:sorted).and_return(sorted_mock)
      get :index
      assigns(:posts).should eq([mock_post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      Post.stub(:find_by_permalink).with("37") { mock_post }
      get :show, :id => "37"
      assigns(:post).should be(mock_post)
    end
  end

end
