class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  def index
    @courses = Course.all
  end  

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
    
    redirect_to @course
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :enrollment_deadline, :price)
  end
end