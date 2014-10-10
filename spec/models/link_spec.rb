require 'spec_helper'

describe Link do
  before(:each) do
    @link = Link.new :url => "http://cliftonstudios.ca"
  end

  describe "validations" do
    it "should fail with an invalid url" do
      @link.url = "pie"
      expect(@link.valid?).to be_falsey
    end

    it "should be ok with a valid url" do
      expect(@link.valid?).to be_truthy
    end
  end

  describe "display" do
    it "should show the title if it is there" do
      @link.title = "pie"
      expect(@link.display).to eq(@link.title)
    end

    it "should fall back to the url" do
      expect(@link.display).to eq(@link.url)
    end
  end
end
