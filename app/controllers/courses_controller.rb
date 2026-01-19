class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to @course, notice: "コースを投稿しました"
    else
      flash.now[:error] = @course.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "コースを更新しました"
    else
      flash.now[:error] = @course.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to mypage_path, notice: "コースを削除しました"
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :distance, :duration, :description, :image)
  end
end
