class Admin::FeedsController < ApplicationController
  before_filter :authenticate unless ENV['RAILS_ENV'] == 'test'
    
  def create
    @category = Category.find(params[:category_id])
    @feed = @category.feeds.build(params[:feed])
    if @feed.url
      feed_to_parse = Feedzirra::Feed.fetch_and_parse(@feed.url)
    end
    if @feed.save
      feed_to_parse.entries.each do |entry|
        Entry.create(:url => entry.url,
                     :title => entry.title,
                     :author => entry.author,
                     :summary => entry.summary,
                     :updated_at => entry.published,
                     :feed_id => @feed.id,
                     :category_id => @category.id)
      end
      @feed.update_attributes(:updated_at => @feed.entries.first.updated_at,
                              :title => feed_to_parse.title,
                              :permalink => feed_to_parse.url,
                              :accepted => true,
                              :etag => feed_to_parse.etag,
                              :last_modified => feed_to_parse.last_modified)
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
