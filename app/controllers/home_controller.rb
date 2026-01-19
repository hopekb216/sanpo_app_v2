class HomeController < ApplicationController
  def index
    @courses = Course.order(created_at: :desc).page(params[:page]).per(6)
  end

  def top
  end
end
