require 'spec_helper'

describe EventsController do

  let(:event){ FactoryGirl.create(:event) }
  let(:events){ [event] }

  describe "GET index" do
    it "assigns all events as @events" do
      Event.should_receive(:upcoming).and_return(events)
      events.should_receive(:paginate).with(an_instance_of(Hash)).and_return(events)
      get :index
      assigns(:events).should eq(events)
      assigns(:title).should eq("Events")
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      Event.stub(:find_by_permalink).with(event.permalink).and_return(event)
      get :show, id: event.permalink
      assigns(:event).should eq(event)
      assigns(:title).should eq("Event :: #{event.title}")
    end
  end

end
