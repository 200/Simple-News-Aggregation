require 'spec_helper'
require 'feedzirra'
describe Feed do
  before :each do
    @feed = {
      :url => "http://feeds.gawker.com/lifehacker/full"
    }
  end

  it "should create new feed" do 
    feed = Feed.create(@feed)
    feed_to_parse = Feedzirra::Feed.fetch_and_parse(feed.url)
    feed.add_feed_with_news

    entry_from_db = feed.entries.last
    entry_parsed = feed_to_parse.entries.last

    entry_from_db.url.should == entry_parsed.url
    entry_from_db.title.should == entry_parsed.title
    entry_from_db.author.should == entry_parsed.author
    entry_from_db.summary.should == entry_parsed.summary
    entry_from_db.content.should == entry_parsed.content

    feed.updated_at.should == feed.entries.first(:order => 'updated_at desc').updated_at
    feed.accepted.should == true
    feed.etag.should == feed_to_parse.etag
    feed.last_modified.should == feed_to_parse.last_modified
    feed.url.should == feed_to_parse.feed_url
    feed.title.should == feed_to_parse.title
    feed.permalink.should == feed_to_parse.url
  end

  it "should create and update feed" do
    feed = Feed.create(@feed)
    feed.add_feed_with_news
    feed_to_parse = Feedzirra::Feed.fetch_and_parse(feed.url)
    Feed.check_feeds_for_news
    updated_feed = Feedzirra::Feed.update(feed_to_parse)
    until feed_to_parse.new_entries.count > 0
      sleep 3.minutes
      Feed.check_feeds_for_news
      updated_feed = Feedzirra::Feed.update(feed_to_parse)
    end
    entry_from_up = updated_feed.new_entries.first
    entry_from_db = feed.entries.find_by_title(entry_from_up.title)

    entry_from_db.url.should == entry_from_up.url
    entry_from_db.title.should == entry_from_up.title
    entry_from_db.author.should == entry_from_up.author
    entry_from_db.summary.should == entry_from_up.summary
    entry_from_db.content.should == entry_from_up.content

    feed = Feed.first
    feed.updated_at.should == feed.entries.find(:first, :order => 'updated_at desc').updated_at
    feed.etag.should == feed_to_parse.etag
    feed.last_modified.should == feed_to_parse.last_modified
  end
end


