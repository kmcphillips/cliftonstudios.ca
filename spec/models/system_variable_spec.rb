require 'spec_helper'

describe SystemVariable do
  let(:system_variable) { SystemVariable.new :key => "pie", :value => "delicious" }

  describe "Class Methods" do
    describe "#get" do
      it "should get the value if the record is present" do
        SystemVariable.should_receive(:find_by_key).with(system_variable.key).and_return(system_variable)
        SystemVariable.get(system_variable.key).should system_variable.value
      end

      it "should return nil if the record does not exist" do
        SystemVariable.should_receive(:find_by_key).with(system_variable.key).and_return(nil)
        SystemVariable.get(system_variable.key).should be_nil
      end
    end

    describe "#readonly?" do
      it "should return the value from the get() call" do
        SystemVariable.should_receive(:get).with("readonly").and_return("true")
        SystemVariable.readonly?.should be_true
      end
    end
  end
end
