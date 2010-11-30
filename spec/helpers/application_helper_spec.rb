require 'spec_helper'

describe ApplicationHelper do
  include ApplicationHelper

  describe "page_title" do
    it "should generate the default title" do
      page_title.should == "Clifton Studios"
    end
  end
end

