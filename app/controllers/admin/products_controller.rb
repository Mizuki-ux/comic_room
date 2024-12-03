class Admin::ProductsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_product, only: %i[show edit update]

  
 def index
    @products = Product.all
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
    @matching_post = @product.posts.find_by(title: @product.name)
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
