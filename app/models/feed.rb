class Feed < ActiveRecord::Base
  belongs_to :category
  has_many :entries, :dependent => :destroy
  
  validates :url, :presence => true, :uniqueness => true


  def self.check_feeds_for_news
      Feed.all.each do |feed|
        feed_to_update = Feedzirra::Parser::Atom.new
        feed_to_update.feed_url = feed.url
        feed_to_update.etag = feed.etag
        feed_to_update.last_modified = feed.last_modified 
        last_entry = Feedzirra::Parser::AtomEntry.new
        last_entry.url = feed.entries.first.url 
        feed_to_update.entries = [last_entry]
        updated_feed = Feedzirra::Feed.update(feed_to_update)

        if updated_feed.new_entries  
          updated_feed.new_entries.each do |entry|
            Entry.create(:url => entry.url,
                         :title => entry.title,
                         :author => entry.author,
                         :summary => entry.summary,
                         :updated_at => entry.published,
                         :feed_id => feed.id,
                         :category_id => feed.category_id)
          end
        end
        feed.update_attributes(:last_modified => updated_feed.last_modified,
                               :etag => feed.etag,
                               :updated_at => feed.entries.first.updated_at) 
    end
  end

end
