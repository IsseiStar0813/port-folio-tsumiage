class LandingPagesController < ApplicationController
  before_action :login_user

  def login_user
    if logged_in? 
      redirect_to current_user
    end
  end
end
