require 'spec_helper'

describe PingController do
  describe "GET index" do
    it "returns a string on ok" do
      get :index
      expect(response.body).to eq("OK")
    end
  end
end

