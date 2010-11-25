class Admin::FeedsController < ApplicationController
  before_filter :authenticate unless ENV['RAILS_ENV'] == 'test'
    
  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    @feed.accepted = true
    if @feed.save
      redirect_to admin_root_path 
    else
      render :action => 'errors', :object => @feed
    end
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

  def errors
    @feed = Feed.find(params[:id])
  end
end
