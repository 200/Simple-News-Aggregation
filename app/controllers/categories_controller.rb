class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @feeds = Feed.all(:order => 'updated_at', :limit => 10)
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @feed = Feed.new
    
  end
end
