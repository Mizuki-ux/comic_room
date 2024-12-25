class Admin::ProductsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_product, only: %i[ edit update]

  
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

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product)
    else
      render :new
    end
  end
  
  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
  end
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to admin_products_path
  end   
  
  def show
    @product = Product.find(params[:id])
    @matching_posts = @product.posts
    @user = current_user
     average_ratings = Post.where.not(star: nil).group(:product_id).average(:star)
    @average_star_rating = average_ratings.transform_values { |rating| rating.round(1) }
  end  

  def edit
  end
  
  
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :image)
  end
  
end
