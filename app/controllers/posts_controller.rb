class PostsController < ApplicationController 
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @post = current_user.posts.build 
  end

  def create 
    @post = current_user.posts.build(post_params)
    if @post.save
      # 投稿成功
      unless current_user.already_posted
          # その日の最初の投稿の場合のみ積み上げをカウント
      @tsumiage_count = current_user.tsumiage_count + 1
      current_user.update(tsumiage_count: @tsumiage_count, already_posted: true)
      end
      flash[:success] = "投稿しました"
      redirect_to current_user
    else
      # 投稿失敗
      render "new"
    end
  end

  def destroy 
    @post = current_user.posts.find_by(id: params[:id])
    unless @post.nil?
      # 削除成功
      @post.destroy
      flash[:success] = "削除しました"
      redirect_to current_user
    else
      # 削除失敗
      flash[:warning] = "他人の投稿は削除できません"
      redirect_to root_url
    end
  end

  # 検索機能
  def search
    @search_posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
   end

  
 
  private
    def post_params
      params.require(:post).permit(:content, :start_time, :title)
    end
  
end
