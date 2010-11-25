class Admin::CategoriesController < ApplicationController
  before_filter :authenticate unless ENV['RAILS_ENV'] == 'test'

  def index
    @categories = Category.all
    @category = Category.new
    @feed = Feed.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category has been successfully created.'
      redirect_to admin_root_path 
    else
      render :action => 'errors', :object => @category 
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = 'Category has been deleted.'
    redirect_to admin_root_path
  end

end
