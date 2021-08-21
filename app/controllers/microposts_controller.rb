class MicropostsController < ApplicationController 
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @micropost = current_user.microposts.build 
  end

  def create 
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # 投稿成功
      @tsumiage_count = current_user.tsumiage_count + 1
      current_user.update_attribute(:tsumiage_count, @tsumiage_count)
      flash[:success] = "投稿しました"
      redirect_to current_user
    else
      # 投稿失敗
      render "new"
    end
  end

  def destroy 
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost.nil?
      # 削除成功
      @micropost.destroy
      flash[:success] = "削除しました"
      redirect_to current_user
    else
      # 削除失敗
      flash[:warning] = "他人の投稿は削除できません"
      redirect_to root_url
    end
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
  
end
