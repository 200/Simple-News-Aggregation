require "spec_helper"

describe CategoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/" }.should route_to(:controller => "categories", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/categories/1" }.should route_to(:controller => "categories", :action => "show", :id => "1")
    end

    it "recognizes and generates #last_entries" do
      { :get => "/last_entries/1" }.should route_to(:controller => "categories", :action => "last_entries", :id => "1")
    end

  end
end
