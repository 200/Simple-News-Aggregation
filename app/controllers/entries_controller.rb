class EntriesController < ApplicationController
  def show
    @entry = Entry.find(params[:id])
    @feed = @entry.feed
    @next_entry = @feed.entries.last(:order => 'updated_at desc', :conditions => ["updated_at > ? AND id != ?", @entry.updated_at, @entry.id]) 
    @previous_entry = @feed.entries.first(:order => 'updated_at desc', :conditions => ["updated_at < ? AND id != ?", @entry.updated_at, @entry.id]) 
    @category_feeds = Feed.all(:limit => 10, :conditions => ["id != ? AND category_id = ?", @feed.id, @feed.category_id])
  end
end
