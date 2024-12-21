class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

def search
    @range = params[:range]
    
     if params[:latest]
     @posts = Post.latest
   elsif params[:old]
     @posts = Post.old
   elsif params[:star_count]
     @posts = Post.star_count
   else
     @posts = Post.all
   end

    if @range == "user"
    if params[:word].blank?
      flash[:error] = "検索条件を入力してください。"
    else
      @users = User.looks(params[:search], params[:word])
    end
  else
    if params[:word].blank?
      flash[:error] = "検索条件を入力してください。"
    else
      @posts = Post.looks(params[:search], params[:word])
      @products = Product.looks(params[:search], params[:word])
    end
  end
end
end

