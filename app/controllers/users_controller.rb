class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]

  def mypage
    @user = current_user
    @courses = @user.courses.order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @courses = @user.courses.order(created_at: :desc).page(params[:page]).per(6)
  end
end
