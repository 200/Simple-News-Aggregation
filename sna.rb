# sna.rb 
require 'rubygems'
require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-migrations'

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
  property :category_id, Integer

  belongs_to :category
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
  property :feed_id, Integer

  belongs_to :feed
end

DataMapper.auto_migrate!

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + "/public"
set :run, true

#Routes

#Categories
get '/categories' do
#  @categories = Category.find_all
  haml :'categories/index'
end

get '/categories/:id' do
#  @category = Category.find(params[:id])
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

# post ''


#Feeds
get '/feeds' do
  haml :'feeds/show'
end

__END__
