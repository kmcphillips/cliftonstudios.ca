require 'spec_helper'

describe Event do
  before(:each) do
    @member = mock_model(Member)
    @valid_attributes = {:title => "title", :member => @member, :body => "body", :starts_at => Time.now, :duration => 1}
  end
  
  describe "ends_at" do
    it "should be set on save" do
      event = Event.create!(@valid_attributes)
      event.ends_at.should == (Time.now.beginning_of_day + 1.day)
    end
  end
  
  after(:each) do
    Event.destroy_all
  end
end
