require 'spec_helper'

describe Admin::FeedsController do

  def mock_category(stubs={})
    (@mock_category ||= mock_model(Category).as_null_object).tap do |category|
      category.stub(stubs) unless stubs.empty?
    end
  end

  def mock_feed(stubs={})
    (@mock_feed ||= mock_model(Feed, :category_id => 10).as_null_object).tap do |feed|
      feed.stub(stubs) unless stubs.empty?
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created feed as @feed" do
        Category.stub(:new).with({'these' => 'params'}) { mock_category(:save => true) }
        Feed.stub(:new).with({'these' => 'params'}) { mock_feed(:category_id => 37, :save => true) }
        post :create, :feed => {'these' => 'params'}
        assigns(:feed).should be(mock_feed)
      end
    end
  end
end
