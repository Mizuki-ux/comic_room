class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page])
      @post = Post.find_by(user_id: params[:id])
    end  
    
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
    
    def search
      @users = User.search(params[:word])
    end
end
