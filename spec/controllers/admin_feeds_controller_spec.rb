require 'spec_helper'

describe Admin::FeedsController do

  describe "POST create" do
    before(:each) do
      @category = Factory.create(:category)
      @request.env['HTTP_REFERER'] = "http://localhost:3000//#{@category.id}"
    end

    describe "with valid params" do
      before(:each) do
        @feed = Factory.attributes_for(:feed)
      end

      it "assigns a newly created feed as @feed" do
        post :create, :feed => @feed, :category_id => @category.id 
        assigns(:feed).title.should == "CNN.com"
        assigns(:feed).accepted.should == true 
        assigns(:feed).category_id.should == @category.id 
      end
      
      it "redirects to the admin panel with a notice on successful save" do
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to(admin_root_path)
      end
    end

    describe "with invalid params" do
      it "redirects to the admin panel with a notice on failure save" do
        @feed = Feed.new(:url => 'wp.pl/123412312')
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to(admin_root_path)
      end

      it "redirects to the admin panel with a notice on failure save" do
        @feed = Feed.new(:url => '123412312')
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to(admin_root_path)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @feed = Factory.create(:feed)
    end

    it "assigns destroyed feed as @feed" do
      delete :destroy, :id => @feed.id 
      assigns(:feed).should eq(@feed) 
    end

    it "redirect to the admin panel with a notice on successful destroy" do
      delete :destroy, :id => @feed.id
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_root_path)
    end
  end

  describe "GET accept" do
    before(:each) do
      @feed = Factory.create(:feed)
    end

    it "assigns requested feed as @feed" do
      get :accept, :id => @feed.id
      assigns(:feed).should eq(@feed) 
    end

    it "add entries to @feed" do
      get :accept, :id => @feed.id
      assigns(:feed).entries.count.should > 0
    end

    it "redirect to the admin panel with a notice on successful accept" do
      get :accept, :id => @feed.id
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_root_path)
    end
  end

  describe "GET reject" do
    before(:each) do
      @feed = Factory.create(:feed)
    end

    it "assigns requested feed as @feed" do
      get :reject, :id => @feed.id 
      assigns(:feed).should eq(@feed) 
    end

    it "redirect to the admin panel with a notice on successful reject" do
      get :reject, :id => @feed.id
      flash[:notice].should_not be_nil
      response.should redirect_to(admin_root_path)
    end
  end
end 
