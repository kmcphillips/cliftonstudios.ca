require 'spec_helper'

describe Event do
  let(:member){ FactoryGirl.create(:member) }
  let(:valid_attributes){ {title: "title", member: member, body: "body", starts_at: Time.zone.now, duration: 1} }

  describe "ends_at" do
    it "should be set on save" do
      event = Event.create!(valid_attributes)
      expect(event.ends_at).to eq(Time.zone.now.beginning_of_day + 1.day)
    end
  end

  after(:each) do
    Event.destroy_all
  end

  describe "class method" do
    let(:in_2012) { Date.parse("01/09/2012").to_time + 20.minutes }
    let(:in_2016) { Date.parse("01/01/2016").to_time }
    let(:in_2017) { Date.parse("02/02/2017").to_time }

    describe "#next_two_sales" do
      shared_context "next_two_sales for" do
        it "should calculate the next two sales after" do
          Timecop.travel(current_time) do
            expect(Event.next_two_sales).to eq(expected_result)
          end
        end
      end

      context "2012" do
        let(:current_time) { in_2012 }
        let(:expected_result) { [[Date.parse("7/12/2012"), Date.parse("8/12/2012")], [Date.parse("3/5/2013"), Date.parse("4/5/2013")]] }

        include_context "next_two_sales for"
      end

      context "2016" do
        let(:current_time) { in_2016 }
        let(:expected_result) { [[Date.parse("6/5/2016"), Date.parse("7/5/2016")], [Date.parse("2/12/2016"), Date.parse("3/12/2016")]] }

        include_context "next_two_sales for"
      end

      context "2017" do
        let(:current_time) { in_2017 }
        let(:expected_result) { [[Date.parse("5/5/2017"), Date.parse("6/5/2017")], [Date.parse("1/12/2017"), Date.parse("2/12/2017")]] }

        include_context "next_two_sales for"
      end
    end
  end
end
