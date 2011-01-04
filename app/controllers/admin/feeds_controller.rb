class Admin::FeedsController < ApplicationController
  before_filter :authenticate unless ENV['RAILS_ENV'] == 'test'

  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    check = Feedzirra::Feed.fetch_and_parse(@feed.url) 
    if check == (404 & 0) or check.nil?
      flash[:notice] = 'Feed url is incorrent.'
    else
      if @feed.save
        @feed.add_feed_with_news
        flash[:notice] = 'Feed has been successfully added.'
      else
        flash[:notice] = @feed.errors.full_messages.to_sentence
      end
    end
    redirect_to admin_root_path 
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = 'Feed has been deleted.'
    redirect_to admin_root_path 
  end

  def accept
    @feed = Feed.find(params[:id])
    @feed.add_feed_with_news
    flash[:notice] = 'Feed has been accepted.'
    redirect_to admin_root_path 
  end

  def reject
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = 'Feed has been rejected.'
    redirect_to admin_root_path  
  end
end
