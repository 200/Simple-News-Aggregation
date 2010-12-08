class CategoriesController < ApplicationController
  def index
    @categories = Category.all(:order => 'name')
    @feeds = Feed.all(:order => 'updated_at DESC', :limit => 10)
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @feed = Feed.new
  end

  def last_entries
    @category = Category.find(params[:id])
    @entries = @category.entries.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 25) 
  end
end
