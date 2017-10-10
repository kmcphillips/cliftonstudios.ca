require 'spec_helper'

describe Minutes do
  let(:minutes){ FactoryGirl.create(:minutes) }

  describe "validations" do
    it "should be valid" do
      expect(minutes).to be_valid
    end
  end
end
