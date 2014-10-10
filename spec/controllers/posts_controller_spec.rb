require 'spec_helper'

describe PostsController do
  let(:post){ FactoryGirl.create(:post) }

  describe "GET index" do
    it "assigns all posts as @posts" do
      sorted_mock = double :sorted
      allow(sorted_mock).to receive(:paginate) { [post] }
      allow(Post).to receive(:sorted).and_return(sorted_mock)
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      expect(Post).to receive(:find_by_permalink).with(post.permalink) { post }
      get :show, id: post.permalink
      expect(assigns(:post)).to be(post)
    end
  end

end
