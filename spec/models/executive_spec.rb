require 'spec_helper'

describe Executive do
  describe "convenience methods" do
    it "should get the president" do
      let(:executive) { mock_model Executive }

      Executive.should_receive(:where).with(:title => "President").and_return([executive])
      Executive.president.should == executive
    end
  end
end
