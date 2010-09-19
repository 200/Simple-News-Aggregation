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
  haml :'categories/index'
end

get '/categories/:id' do
  @category = params[:id]
  haml :'categories/show'
end

#Feeds
get '/feeds' do
  haml :'feeds/show'
end

__END__
