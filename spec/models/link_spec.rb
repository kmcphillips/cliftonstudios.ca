require 'spec_helper'

describe Link do
  before(:each) do
    @link = Link.new :url => "http://cliftonstudios.ca"
  end

  describe "validations" do
    it "should fail with an invalid url" do
      @link.url = "pie"
      @link.valid?.should be_false
    end

    it "should be ok with a valid url" do
      @link.valid?.should be_true
    end
  end

  describe "display" do
    it "should show the title if it is there" do
      @link.title = "pie"
      @link.display.should == @link.title
    end

    it "should fall back to the url" do
      @link.display.should == @link.url
    end
  end
end
