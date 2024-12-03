class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @matching_post = @product.posts.find_by(title: @product.name)
    @user = User.find(params[:id])
  end

  private

  
end