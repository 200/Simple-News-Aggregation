require 'spec_helper'

describe Admin::CategoriesController do

  def mock_category(stubs={})
    (@mock_category ||= mock_model(Category).as_null_object).tap do |category|
      category.stub(stubs) unless stubs.empty?
    end
  end

  def mock_feed(stubs={})
    (@mock_feed ||= mock_model(Feed).as_null_object).tap do |feed|
      feed.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      Category.stub(:all) { [mock_category] }
      get :index
      assigns(:categories).should eq([mock_category])
    end

    it "assigns new category as @category" do
      Category.stub(:new) { mock_category }
      get :index
      assigns(:category).should be(mock_category)
    end

    it "assigns new feed as @feed" do
      Feed.stub(:new) { mock_feed }
      get :index
      assigns(:feed).should be(mock_feed)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created category as @category" do
        Category.stub(:new).with({'these' => 'params'}) { mock_category(:save => true) }
        post :create, :category => {'these' => 'params'}
        assigns(:category).should be(mock_category)
      end

      it "redirects to the index with a notice on successful save" do
        Category.stub(:new) { mock_category(:save => true) }
        post :create, :category => {}
        flash[:notice].should_not be_nil
        response.should redirect_to(admin_root_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        Category.stub(:new).with({'these' => 'params'}) { mock_category(:save => false) }
        post :create, :category => {'these' => 'params'}
        assigns(:category).should be(mock_category)
      end

      it "renders the 'errors' template" do
        Category.stub(:new) { mock_category(:save => false) }
        post :create, :category => {}
        response.should render_template("errors")
      end
    end
  end  

  describe "DELETE destroy" do
    it "destroys the requested category" do
      Category.should_receive(:find).with("37") { mock_category }
      mock_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the index with a notice on successful destroy" do
      Category.stub(:find) { mock_category }
      delete :destroy, :id => "1"
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_root_path)
    end
  end

end
