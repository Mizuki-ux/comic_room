class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
    
     if params[:latest]
       @products = Product.latest
     elsif params[:old]
       @products = Product.old
     elsif params[:star_count]
       @products = Product.star_count
     else
       @products = Product.all
     end
  end

  def show
    @product = Product.find(params[:id])
    @matching_posts = @product.posts
    @user = current_user
    average_ratings = Post.where.not(star: nil).group(:product_id).average(:star)
    @average_star_rating = average_ratings.transform_values { |rating| rating.round(1) }

  end

  private

  
end