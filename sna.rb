require 'sinatra'
require 'sinatra/mapping'
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

#Test data
unless Category.first
  7.times do
    Category.create(:name => "category1", :permalink => "link")
  end

  7.times do
    Feed.create(:url => "url.com",
                :title => "feed1",
                :permalink => "sna.com",
                :accepted => true,
                :category_id => 1
               )
  end
  Feed.create(:url => "url.com",
              :title => "feed1",
              :permalink => "sna.com",
              :accepted => true,
              :category_id => 1, 
              :timestamps => Time.now
             )
end

#Routes
#Categories
get '/categories' do
  haml :'categories/index',
       :locals => { :categories => Category.all,
                    :last_feeds => Feed.all(:limit => 10,
                                            :order => "timestamps"),
                  }
end

get '/categories/:id' do
  @category = Category.find(params[:id])
  haml :'categories/show'
end

get 'categories/new' do
#  @category = Category.new
  haml :'catgories/new'
end

get 'categories/:id/edit' do
#  @category = Category.find(params[:id])
  haml :'categories/new'
end
