class PostsController < ApplicationController 
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :already_posted?, only: :create

  def new
    @post = current_user.posts.build 
  end

  def create 
    @post = current_user.posts.build(post_params)
    if @post.save
      # 投稿成功
      @tsumiage_count = current_user.tsumiage_count + 1
      current_user.update(tsumiage_count: @tsumiage_count, already_posted: true)
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
 
  # すでに投稿済みかどうか
  def already_posted?
    if current_user.already_posted
      # ユーザーが既に投稿済みの場合
      flash[:warning] = "投稿は一日一回です"
      redirect_to current_user
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
  
end
