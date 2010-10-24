require 'spec_helper'

describe AdminController do

  describe "GET 'panel'" do
    it "should be successful" do
      get 'panel'
      response.should be_success
    end
  end

end
