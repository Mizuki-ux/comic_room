class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_post, only: %i[show update]

  def show
    @posts = Post.page(params[:page])
    @post_comment = PostComment.new
    @user = current_user
    if @product.present?
    @matching_post = @product.posts.find_by(title: @product.name)
  else
    # @productが存在しない場合の処理
  end
  end

  def search
    @posts = Post.search(params[:word])
  end

  def update
    @post.update(post_params)
    redirect_to request.referer, notice: 'Successfully updated customer status'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:customer).permit(:status)
  end
end
