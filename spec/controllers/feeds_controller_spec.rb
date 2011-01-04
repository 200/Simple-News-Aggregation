require 'spec_helper'

describe FeedsController do

  describe "POST create from categories show" do
    before(:each) do
      @category = Factory.create(:category)
      @request.env['HTTP_REFERER'] = "http://localhost:3000/categories/#{@category.id}"
    end

    describe "with valid params" do
      before(:each) do
        @feed = Factory.attributes_for(:feed)
      end

      it "assigns a newly created feed as @feed" do
        post :create, :feed => @feed, :category_id => @category.id 
        assigns(:feed).title.should == "CNN.com"
        assigns(:feed).accepted.should == nil
        assigns(:feed).category_id.should == @category.id 
      end
      
      it "redirects to the back page with a notice on successful save" do
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to :back
      end
    end

    describe "with invalid params" do
      it "redirects to the back page with a notice on failure save" do
        @feed = Feed.new(:url => 'wp.pl/123412312')
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to :back
      end

      it "redirects to the back page with a notice on failure save" do
        @feed = Feed.new(:url => '123412312')
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to :back
      end

    end
  end

  describe "POST create from categories last_entries" do
    before(:each) do
      @category = Factory.create(:category)
      @request.env['HTTP_REFERER'] = "http://localhost:3000/last_entries/#{@category.id}"
    end

    describe "with valid params" do
      before(:each) do
        @feed = Factory.attributes_for(:feed)
      end

      it "assigns a newly created feed as @feed" do
        post :create, :feed => @feed, :category_id => @category.id 
        assigns(:feed).title.should == "CNN.com"
        assigns(:feed).accepted.should == nil
        assigns(:feed).category_id.should == @category.id 
      end
      
      it "redirects to the back page with a notice on successful save" do
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to :back
      end
    end

    describe "with invalid params" do
      it "redirects to the back page with a notice on failure save" do
        @feed = Feed.new(:url => 'wp.pl/123412312')
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to :back
      end

      it "redirects to the back page with a notice on failure save" do
        @feed = Feed.new(:url => '123412312')
        post :create, :feed => @feed, :category_id => @category.id 
        flash[:notice].should_not be_nil
        response.should redirect_to :back
      end

    end
  end
end
