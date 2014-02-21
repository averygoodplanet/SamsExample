require 'spec_helper'

describe HomeController do

  # GET request to index should be successful
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
