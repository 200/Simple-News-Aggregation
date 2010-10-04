require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-migrations'
require 'dm-constraints'

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + "/public"
set :run, true

DataMapper.setup(:default ,'postgres://localhost/sna_development')

# Models
class Category
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :permalink, String

  has n, :feeds
end

class Feed
  include DataMapper::Resource

  property :id, Serial
  property :url, String
  property :title, String
  property :permalink, String
  property :accepted, Boolean
  property :timestamps, DateTime

  belongs_to :category, :child_key => [ :category_id ]
  has n, :entries
end

class Entry
  include DataMapper::Resource

  property :url, String
  property :title, String
  property :author, String
  property :id, Serial
  property :summary, Text
  property :timestamps, DateTime

  belongs_to :feed, :child_key => [ :feed_id ]
end

DataMapper.auto_migrate!
unless Category.first
  category1 = Category.create(:name => "category1", :permalink => "link")
  category2 = Category.create(:name => "category2", :permalink => "link2")
  category3 = Category.create(:name => "category3", :permalink => "link3")
  category4 = Category.create(:name => "category4", :permalink => "link4")

  feed1 = Feed.create(:url => "url.com", :title => "feed1", :permalink => "sna.com",
                    :accepted => true, :category_id => 1 )

  feed2 = Feed.create(:url => "url.com", :title => "feed2", :permalink => "sna.com",
                    :accepted => true, :category_id => 1 )
  entry1 = Entry.create(:url => "url.com", :title => "title", :feed_id => 2,
                        :author => "goozzik", :summary => "testowy entry", :timestamps => Time.now)
  entry2 = Entry.create(:url => "url.com", :title => "title", :feed_id => 1,
                        :author => "goozzik", :summary => "testowy entry", :timestamps => Time.now)

end
#Test data

#Routes
#Categories
get '/categories' do
  haml :'categories/index',
       :locals => { 
                    :categories => Category.all,
                    :last_feeds => Feed.all(:limit => 10,
                                            :order => "timestamps")
                  }
end

get '/categories/:id' do
  haml :'categories/show',
       :locals => { 
                    :categories => Category.all,
                    :category => Category.get(params[:id])
                  }
end
