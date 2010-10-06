require 'sinatra'
require 'haml'

set :haml, {:format => :html5 }
set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + "/public"
set :run, true

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
