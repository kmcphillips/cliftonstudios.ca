require 'spec_helper'

describe Member do
  
  describe "admin?" do
    it "should know we are admin" do
      Member.new(:status => "admin").admin?.should be_true
    end
    
    it "should know we are not admin" do
      Member.new(:status => "pie").admin?.should be_false
    end
  end
  
  describe "active?" do
    it "should know we are active" do
      Member.new(:status => "active").active?.should be_true
    end
    
    it "should know we are active if we are an admin" do
      Member.new(:status => "admin").active?.should be_true
    end

    it "should know we are not active" do
      Member.new(:status => "deactive").active?.should be_false
    end
  end
end
