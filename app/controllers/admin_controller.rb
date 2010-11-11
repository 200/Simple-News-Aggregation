class AdminController < ApplicationController
  def panel
    @categories = Category.all
    @category = Category.new
  end

end
