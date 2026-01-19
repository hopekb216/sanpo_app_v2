class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: t("posts.flash.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t("posts.flash.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t("posts.flash.destroyed")
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
