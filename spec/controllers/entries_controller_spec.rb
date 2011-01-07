require 'spec_helper'

describe EntriesController do

  before(:each) do
    @feed = Factory.create(:feed)
    @feed.add_feed_with_news
    @entry = @feed.entries[3]
  end

  describe "GET show" do
    it "assigns the requested entry as @entry" do
      get :show, :id => @entry.id 
      assigns(:entry).should eq(@entry)
    end
    
    it "assigns parent feed as @feed" do
      get :show, :id => @entry.id
      assigns(:feed).should eq(@feed)
    end
    
    it "assigns a next entry as @next_entry" do
      get :show, :id => @entry.id 
      next_entry = @feed.entries.last(:order => 'updated_at desc', :conditions => ["updated_at > ? AND id != ?", @entry.updated_at, @entry.id])
      assigns(:next_entry).should eq(next_entry)
    end

    it "assigns a previous entry as @previous_entry" do
      previous_entry =  @feed.entries.first(:order => 'updated_at desc', :conditions => ["updated_at < ? AND id != ?", @entry.updated_at, @entry.id]) 
      get :show, :id => @entry.id 
      assigns(:previous_entry).should eq(previous_entry)
    end
  end
end
