require 'spec_helper'

describe EventsController do

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event).as_null_object).tap do |event|
      event.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all events as @events" do
      sorted_mock = mock :upcoming
      sorted_mock.stub(:paginate) { [mock_event] }
      Event.stub(:upcoming).and_return(sorted_mock)
      get :index
      assigns(:events).should eq([mock_event])
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      Event.stub(:find).with("37") { mock_event }
      get :show, :id => "37"
      assigns(:event).should be(mock_event)
    end
  end

end
