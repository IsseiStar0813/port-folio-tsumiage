class MicropostsController < ApplicationController 
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @micropost = current_user.microposts.build 
  end

  def create 
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # 投稿成功
      flash[:success] = "投稿しました"
      redirect_to current_user
    else
      # 投稿失敗
      render "new"
    end
  end

  def destroy 
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
  
end
