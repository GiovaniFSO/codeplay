class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update]

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
      render :new
    end
  end

  def edit; end

  def update
    @course.update(course_params)
    redirect_to @course, notice: 'Curso atualizado com sucesso'
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path, notice: 'Curso apagado com sucesso'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :enrollment_deadline, :price)
  end
end