class CategoriesController < ApplicationController
  def index
    @categories = Category.all(:order => 'name')
    @entries = Entry.all(:order => 'updated_at DESC', :limit => 10)
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @feed = Feed.new
  end

  def last_entries
    @category = Category.find(params[:id])
    @feed = Feed.new
    @entries = @category.entries.paginate(:page => params[:page], :order => 'updated_at DESC', :per_page => 25) 
    @atom_entries = @category.entries(:order => 'updated_at DESC')
    @atom_link = "#{@category.id}.atom"
    respond_to do |format|
      format.html
      format.atom { render :action => 'last_entries', :layout => false }
    end
  end

end
