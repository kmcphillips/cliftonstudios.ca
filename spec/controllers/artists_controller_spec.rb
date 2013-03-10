require 'spec_helper'

describe ArtistsController do

  let(:member){ FactoryGirl.create(:member) }

  describe "GET index" do
    it "assigns all members as @members" do
      Member.should_receive(:for_artists_index).and_return([member])
      get :index
      assigns(:members).should eq([member])
    end
  end

  describe "GET show" do
    it "assigns the requested member as @member" do
      Member.stub(:find_by_permalink).with(member.permalink).and_return(member)
      get :show, id: member.permalink
      assigns(:member).should be(member)
      assigns(:title).should eq(member.name)
    end
  end

end

