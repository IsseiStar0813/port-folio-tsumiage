class CalendersController < ApplicationController
  def index
    @user = current_user
    @calenders = @user.calenders
  end
end
