class Feed < ActiveRecord::Base
  belongs_to :category
  has_many :entries, :dependent => :destroy
  
  validates_presence_of :url
  validates_uniqueness_of :url, :scope => :category_id

  def add_feed_with_news
    feed_to_parse = Feedzirra::Feed.fetch_and_parse(self.url) 
    feed_to_parse.entries.each do |entry|
      Entry.create(
        :url => entry.url,
        :title => entry.title,
        :author => entry.author,
        :summary => entry.summary,
        :content => entry.content,
        :updated_at => entry.published,
        :feed_id => self.id,
        :category_id => self.category_id
      )
     end
     self.update_attributes(
       :updated_at => self.entries.first(:order => 'updated_at desc').updated_at,
       :title => feed_to_parse.title,
       :permalink => feed_to_parse.url,
       :accepted => true,
       :etag => feed_to_parse.etag,
       :last_modified => feed_to_parse.last_modified
     )
  end

  def self.check_feeds_for_news
    Feed.where(:accepted => true).each do |feed|
      feed_to_update = Feedzirra::Parser::Atom.new
      feed_to_update.feed_url = feed.url
      feed_to_update.etag = feed.etag
      feed_to_update.last_modified = feed.last_modified 
      last_entry = Feedzirra::Parser::AtomEntry.new
      last_entry.url = feed.entries.first(:order => 'updated_at desc').url 
      feed_to_update.entries = [last_entry]
      updated_feed = Feedzirra::Feed.update(feed_to_update)
      if updated_feed.new_entries.count > 0  
        updated_feed.new_entries.each do |entry|
          unless feed.entries.exists?(:title => entry.title)
            feed.entries.create(
              :url => entry.url,
              :title => entry.title,
              :author => entry.author,
              :summary => entry.summary,
              :content => entry.content,
              :updated_at => entry.published
            )
          end
        end
        feed.update_attributes(
          :last_modified => updated_feed.last_modified,
          :etag => updated_feed.etag,
          :updated_at => feed.entries.first(:order => 'updated_at desc').updated_at
        ) 
      end
    end
  end
end
