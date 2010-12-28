class FeedsController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    if @category.feeds.exists?(:url => @feed.url)
      flash[:notice] = 'Feed already exists in this category.' 
      redirect_to :back 
    else
      if parsed = (Feedzirra::Feed.fetch_and_parse(@feed.url) == (0 or 404))
        flash[:notice] = 'Feed url is incorrent.'
        redirect_to :back
      else
        @feed.title = parsed.title
        @feed.save
        flash[:notice] = 'Your proposal is waiting for admin acceptance.'
        redirect_to :back
      end
    end
  end
end
