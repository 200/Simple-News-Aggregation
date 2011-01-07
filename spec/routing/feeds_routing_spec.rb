require "spec_helper"

describe FeedsController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/feeds/1" }.should route_to(:controller => "feeds", :action => "show", :id => "1")
    end

    it "recognizes and generates #create - categories/show" do
      { :post => "categories/1/feeds" }.should route_to(:controller => "feeds", :action => "create", :category_id => "1")
    end

    it "recognizes and generates #create - categories/last_entries" do
      { :post => "last_entries/1/feeds" }.should route_to(:controller => "feeds", :action => "create", :category_id => "1")
    end

  end
end
