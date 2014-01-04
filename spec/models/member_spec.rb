require 'spec_helper'

describe Member do
  let(:member){ FactoryGirl.create(:member) }

  describe "validations" do
    it "should be valid from the factory" do
      member.should be_valid
    end

    it "should check that the phone has an area code" do
      member.phone = "123-1234"
      member.should_not be_valid
    end

    it "should check that the alternate_phone has an area code" do
      member.alternate_phone = "123-1234"
      member.should_not be_valid
    end

    it "should allow blank phones" do
      member.phone = nil
      member.alternate_phone = ""
      member.should be_valid
    end
  end

  describe "callbacks" do
    describe "#format_phone_numbers" do
      it "should return true" do
        member.send(:format_phone_numbers).should be_true
      end

      it "should skip blank numbers" do
        member.phone = nil
        member.alternate_phone = ""
        member.send(:format_phone_numbers)
        member.phone.should be_nil
        member.alternate_phone.should eq("")
      end

      it "should strip the leading 1" do
        member.phone = "1-222-333-4444"
        member.send(:format_phone_numbers)
        member.phone.should eq("222-333-4444")
      end

      it "should strip special characters" do
        member.phone = " (222) -333-4444.. "
        member.send(:format_phone_numbers)
        member.phone.should eq("222-333-4444")
      end
    end
  end

  describe "scopes" do
    describe "#public" do
      it "should not include system users" do
        FactoryGirl.create_list(:member, 3)
        FactoryGirl.create(:member, system: true)
        expect(Member.count).to eq(4)
        expect(Member.public.count).to eq(3)
      end
    end
  end

end
