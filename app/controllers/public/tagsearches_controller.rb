class Public::TagsearchesController < ApplicationController
  def search
   
    @category = params[:category]
    @posts = Post.where("category LIKE?","%#{@category}%")
    

   if @posts.present?
      # カテゴリーが一致する場合、結果を表示
     @posts = @posts.includes(:favorites).sort_by { |post| post.favorites.count }.reverse # いいね数順にソート
    else
      # カテゴリーが一致しない場合、エラーメッセージを設定
      flash[:error] = "該当するカテゴリーは見つかりませんでした。"
      # redirect_to tagsearches_search_path
    end
      render "tagsearch"
  end
end
