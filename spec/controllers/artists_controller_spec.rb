require 'spec_helper'

describe ArtistsController do

  def mock_member(stubs={})
    (@mock_member ||= mock_model(Member).as_null_object).tap do |member|
      member.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all members as @members" do
      Member.stub(:order) { [mock_member] }
      get :index
      assigns(:members).should eq([mock_member])
    end
  end

  describe "GET show" do
    it "assigns the requested member as @member" do
      Member.stub(:find_by_permalink).with("37") { mock_member }
      get :show, :id => "37"
      assigns(:member).should be(mock_member)
    end
  end

end

