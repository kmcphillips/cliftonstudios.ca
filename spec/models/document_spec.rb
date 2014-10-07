require 'spec_helper'

describe Document do
  let(:bylaw){ FactoryGirl.create(:document, kind: 'bylaw') }

  describe "validations" do
    it "should be valid" do
      expect(bylaw).to be_valid
    end
  end

  describe "#bylaw?" do
    it "should know if the kind if a bylaw" do
      expect(bylaw.bylaw?).to be_true
      bylaw.kind = 'pie'
      expect(bylaw.bylaw?).to be_false
    end
  end
end
