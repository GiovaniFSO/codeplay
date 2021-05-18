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
    @course = Course.new(course_params)
    
    if @course.save
      redirect_to @course, notice: "#{@course.name} salvo com sucesso!"
    else
      flash.now[:alert] = @course.errors.full_messages
      render :new
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :enrollment_deadline, :price)
  end
end