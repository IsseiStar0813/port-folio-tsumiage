class PostsController < ApplicationController 
  before_action :logged_in_user
  before_action :require_created_params, only: :index

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
      flash[:green] = "投稿しました"
      redirect_to @post
    else
      # 投稿失敗
      render "new"
    end
  end

  def show
    @post = current_user.posts.find_by(id: params[:id])
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
  end

  def index
    @posted_day = params[:created]
    @posts = current_user.posts.where(created_at: @posted_day.in_time_zone.all_day)
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update(post_params)
      # 更新成功
      flash[:green] = "投稿を更新しました"
      redirect_to @post
    else
      # 更新失敗
      render 'edit'
    end
  end

  def destroy 
    @post = current_user.posts.find_by(id: params[:id])
    unless @post.nil?
      # 削除成功
      @post.destroy
      flash[:red] = "削除しました"
      redirect_to current_user
    else
      # 削除失敗
      flash[:red] = "他人の投稿は削除できません"
      redirect_to root_url
    end
  end

  # 検索機能
  def search
    if params[:keyword]
      @search_posts = Post.search(params[:keyword])
      @keyword = params[:keyword]
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :start_time, :title)
    end
  
end
