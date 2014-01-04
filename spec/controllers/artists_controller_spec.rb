require 'spec_helper'

describe ArtistsController do
  let(:member){ FactoryGirl.create(:member) }

  describe "GET index" do
    it "assigns all members as @members" do
      expect(Member).to receive(:public).and_return(Member)
      expect(Member).to receive(:for_artists_index).and_return([member])
      get :index
      expect(assigns(:members)).to eq([member])
    end
  end

  describe "GET show" do
    it "assigns the requested member as @member" do
      allow(Member).to receive(:find_by_permalink!).with(member.permalink).and_return(member)
      get :show, id: member.permalink
      expect(assigns(:member)).to be(member)
      expect(assigns(:title)).to eq(member.name)
    end
  end

end

