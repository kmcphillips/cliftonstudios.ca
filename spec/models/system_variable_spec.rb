require 'spec_helper'

describe SystemVariable do
  let(:system_variable) { SystemVariable.new :key => "pie", :value => "delicious" }

  describe "Class Methods" do
    describe "#get" do
      it "should get the value if the record is present" do
        expect(SystemVariable).to receive(:find_by_key).with(system_variable.key).and_return(system_variable)
        expect(SystemVariable.get(system_variable.key)).to eq(system_variable.value)
      end

      it "should return nil if the record does not exist" do
        expect(SystemVariable).to receive(:find_by_key).with(system_variable.key).and_return(nil)
        expect(SystemVariable.get(system_variable.key)).to be_nil
      end
    end

    describe "#readonly?" do
      it "should return the value from the get() call" do
        expect(SystemVariable).to receive(:get).with("readonly").and_return("true")
        expect(SystemVariable.readonly?).to be_true
      end
    end
  end
end
