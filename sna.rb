# sna.rb 
require 'rubygems'
require 'sinatra'
require 'haml'

enable :run

get '/' do
  'Hello world!'
end

__END__

@@ layout
%html
  = yield
