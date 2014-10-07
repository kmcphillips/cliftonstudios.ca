require 'spec_helper'

describe Document do
  let(:bylaw){ FactoryGirl.create(:document, kind: 'bylaw') }

  describe "validations" do
    it "should be valid" do
      expect(bylaw).to be_valid
    end
  end
end
