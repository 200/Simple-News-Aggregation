require 'sinatra'
require 'haml'

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + "/public"
set :run, true

get '/' do
  haml :'index/index'
end

get '/categories' do
  haml :'categories/index'
end

get '/categories/empty' do
  haml :'categories/index_empty'
end

get '/categories/show' do
  haml :'categories/show'
end

get '/categories/show/empty' do
  haml :'categories/show_empty'
end

get '/feeds' do
  haml :'feeds/index'
end

get '/feeds/show' do
  haml :'feeds/show'
end

get '/admin' do
  haml :'admin/panel'
end
