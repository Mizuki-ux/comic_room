class UsersController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def mypage
    @users = User.all
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @post = Post.find_by(user_id: params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @post = Post.find_by(user_id: params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
       flash[:notice] = "successful update"
      redirect_to user_path(current_user)
     else
       render :edit
     end    
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
   if @user
    @user.destroy
    flash[:notice] = "The user has been unsubscribed"
    redirect_to root_path
   else
    flash[:alert] = "User not found"
    redirect_to root_path
   end
  end   

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :profile_image)
  end
end
