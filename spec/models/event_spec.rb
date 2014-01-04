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

  describe "class method" do
    before(:each) do
      Timecop.freeze(Date.parse("01/09/2012").to_time + 20.minutes)
    end

    describe "#next_two_meetings" do
      it "should calculate the next two meetings" do
        Event.next_two_meetings.should eq([Date.parse("04/10/2012"), Date.parse("04/04/2013")])
      end
    end

    describe "#next_two_sales" do
      it "should calculate the next two sales" do
        Event.next_two_sales.should eq([[Date.parse("24/11/2012"), Date.parse("25/11/2012")], Date.parse("04/05/2013")])
      end
    end

    after(:each) do
      Timecop.return
    end
  end
end
