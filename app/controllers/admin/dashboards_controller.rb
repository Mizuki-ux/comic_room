class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
    def index
      @users_count = User.count
      @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page])
      @post = Post.find_by(user_id: params[:id])
      @post_comment = PostComment.new
    end   
end
