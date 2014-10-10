require 'spec_helper'

describe EventsController do

  let(:event){ FactoryGirl.create(:event) }
  let(:events){ [event] }

  describe "GET index" do
    it "assigns all events as @events" do
      expect(Event).to receive(:upcoming).and_return(events)
      expect(events).to receive(:paginate).with(an_instance_of(Hash)).and_return(events)
      get :index
      expect(assigns(:events)).to eq(events)
      expect(assigns(:title)).to eq("Events")
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      allow(Event).to receive(:find_by_permalink).with(event.permalink).and_return(event)
      get :show, id: event.permalink
      expect(assigns(:event)).to eq(event)
      expect(assigns(:title)).to eq("Event - #{event.title}")
    end
  end

end
