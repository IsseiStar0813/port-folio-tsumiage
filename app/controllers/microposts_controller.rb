class MicropostsController < ApplicationController 
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @micropost = current_user.microposts.build 
  end

  def create 
  end

  def destroy 
  end
  
end
