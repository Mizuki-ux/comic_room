class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @products = Product.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
      if @post.save
        flash[:notice] = "successful post"
       redirect_to posts_path
      else
        @user = current_user
        @posts = Post.all
        render :new
      end   
  end

  def index
    @users = User.all
    @post = Post.new
    @posts = Post.page(params[:page])
    @user = current_user
  end

  def show
    @post = Post.find(params[:id]) 
    @user = current_user
    @posts = Post.page(params[:page])
    @post_comment = PostComment.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
     if @post.update(post_params)
        flash[:notice] = "successful update"
       redirect_to @post 
     else
       render :edit
     end    
  end   

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to post_path
  end
  
  def search
    @posts = Post.search(params[:word])
  end

  private

  def post_params
    params.require(:post).permit(:title, :user_id, :body, :image, :product_id)
  end
end