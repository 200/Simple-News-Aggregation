class Admin::FeedsController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    @feed.save
    redirect_to admin_root_path 
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to admin_root_path
  end

  def accept
    @feed = Feed.find(params[:id])
    @feed.update_attributes(:accepted => true)
    redirect_to admin_root_path
  end

  def reject
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to admin_root_path
  end
end
