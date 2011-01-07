class FeedsController < ApplicationController
  def show
    @feed = Feed.find(params[:id])
    @entries = @feed.entries.paginate(:page => params[:page], :order => 'updated_at DESC', :per_page => 25) 
    @other_feeds = Feed.all(:limit => 10,  :conditions => ["id != ?", @feed.id]) 
  end

  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    check = Feedzirra::Feed.fetch_and_parse(@feed.url)
    if check == (0 & 404) or check.nil?
      flash[:notice] = 'Feed url is incorrent.'
    else
      if @feed.save
        @feed.update_attribute(:title, check.title) 
        flash[:notice] = 'Your proposal is waiting for admin acceptance.'
      else
        flash[:notice] = @feed.errors.full_messages.to_sentence
      end
    end
    redirect_to :back
  end
end
