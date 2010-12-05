class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @feeds = Feed.all(:order => 'updated_at', :limit => 10)
  end
end
