require 'spec_helper'

describe CategoriesController do

  def mock_category(stubs={})
    (@mock_category ||= mock_model(Category).as_null_object).tap do |category|
      category.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      Category.stub(:all) { [mock_category] }
      get :index
      assigns(:categories).should eq([mock_category])
    end

    it "assigns 10 last entries as @entries" do
      last_entries = Entry.all(:order => 'updated_at', :limit => 10)
      get :index
      assigns(:entries).should eq(last_entries)
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      Category.stub(:find).with("37") { mock_category }
      get :show, :id => "37"
      assigns(:category).should be(mock_category)
    end
    
    it "assigns all categories as @categories" do
      Category.stub(:find).with("37") { mock_category }
      get :show, :id => "37"
      assigns(:categories).should eq(Category.all)
    end
    
    it "assigns a new feed as @feed" do
      Category.stub(:find).with("37") { mock_category }
      get :show, :id => "37"
      assigns(:feed).should be_kind_of(Feed)
    end
  end

  describe "GET last_entries" do
    it "assigns the requested category as @category" do
      Category.stub(:find).with("37") { mock_category }
      get :last_entries, :id => "37"
      assigns(:category).should be(mock_category)
    end

    it "assigns a new feed as @feed" do
      Category.stub(:find).with("37") { mock_category }
      get :last_entries, :id => "37"
      assigns(:feed).should be_kind_of(Feed)
    end

    it "assigns a 25 entries per page as @entries" do
      Category.stub(:find).with("37") { mock_category }
      entries = mock_category.entries.all(:limit => 25, :order => 'updated_at DESC') 
      get :last_entries, :id => "37"
      assigns(:entries).should eq(entries) 
    end
  end
end
