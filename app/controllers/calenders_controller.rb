class CalendersController < ApplicationController
  def index
    @calenders = Calender.all
  end
end
