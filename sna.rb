# sna.rb 
require 'rubygems'
require 'sinatra'
require 'haml'

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + "/public"
set :run, true

#Categories
get '/categories' do
  @categories = Category.find_all
  haml :'categories/index'
end

get '/categories/:id' do
  @category = Category.find(params[:id])
  haml :'categories/show'
end

get 'categories/new' do
  @category = Category.new
  haml :'catgories/new'
end

get 'categories/:id/edit' do
  @category = Category.find(params[:id])
  haml :'categories/new'
end

post ''


#Feeds
get '/feeds' do
  haml :'feeds/show'
end

__END__
