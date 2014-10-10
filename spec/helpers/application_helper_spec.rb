require 'spec_helper'

describe ApplicationHelper do
  describe "page_title" do
    it "should generate the default title" do
      expect(helper.page_title).to eq("Clifton Studios")
    end

    it "should generate the page title with an @title" do
      instance_variable_set('@title', "Pie")
      expect(helper.page_title).to eq("Clifton Studios :: Pie")
    end

    it "should know the members area" do
      expect(helper).to receive(:members_area?).and_return(true)
      expect(helper.page_title).to eq("Clifton Studios :: Members Area")
    end

    it "should handle the blocks controller" do
      allow(helper).to receive(:params).and_return(controller: "blocks", action: "cake")
      expect(helper.page_title).to eq("Clifton Studios :: Cake")
    end

    it "should handle the most complex case" do
      expect(helper).to receive(:members_area?).and_return(true)
      instance_variable_set('@title', "Delicious")
      expect(helper.page_title).to eq("Clifton Studios :: Members Area :: Delicious")
    end
  end

  describe "members_area?" do
    it "should know if it is not members area" do
      allow(helper).to receive(:params).and_return(controller: "posts")
      expect(helper.members_area?).to be_falsey
    end

    it "should know if it is members area" do
      allow(helper).to receive(:params).and_return(controller: "members/posts")
      expect(helper.members_area?).to be_truthy
    end
  end

  describe "truncate_for_index" do
    it "should shorten the string" do
      expect(helper.truncate_for_index("a" * 200)).to eq(("a" * 111) + " (more..)")
    end
  end

  describe "boolean_image" do
    it "should generate for true" do
      expect(helper).to receive(:image_tag).with("/images/icons/true.png", alt: "True").and_return("pie")
      expect(helper.boolean_image(true)).to eq("pie")
    end

    it "should generate for false" do
      expect(helper).to receive(:image_tag).with("/images/icons/false.png", alt: "False").and_return("pie")
      expect(helper.boolean_image(false)).to eq("pie")
    end

    it "should generate false for nil" do
      expect(helper).to receive(:image_tag).with("/images/icons/false.png", alt: "False").and_return("pie")
      expect(helper.boolean_image(nil)).to eq("pie")
    end
  end

  describe "enlarge_button" do
    it "should generate the button and image" do
      expect(helper).to receive(:image_tag).with("/images/icons/magnify.png", alt: "Enlarge", class: :magnify).and_return("pie")
      expect(helper.enlarge_button).to eq("Enlarge&nbsp;pie")
    end
  end

end
