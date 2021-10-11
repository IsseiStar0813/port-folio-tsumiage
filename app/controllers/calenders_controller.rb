class CalendersController < ApplicationController
  
  def index 
    @user = current_user
    @posts = @user.posts.all
  end

end
