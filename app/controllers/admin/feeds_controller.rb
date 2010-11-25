class Admin::FeedsController < ApplicationController
  before_filter :authenticate unless ENV['RAILS_ENV'] == 'test'
    
  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    @feed.accepted = true
    if @feed.save
      flash[:notice] = 'Feed has been successfully added.'
      redirect_to admin_root_path 
    else
      render :action => 'errors', :object => @feed
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = 'Feed has been deleted.'
    redirect_to admin_root_path
  end

  def accept
    @feed = Feed.find(params[:id])
    @feed.update_attributes(:accepted => true)
    flash[:notice] = 'Feed has been accepted.'
    redirect_to admin_root_path
  end

  def reject
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = 'Feed has been rejected.'
    redirect_to admin_root_path
  end

  def errors
    @feed = Feed.find(params[:id])
  end
end
