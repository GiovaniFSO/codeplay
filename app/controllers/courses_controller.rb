class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update enroll]

  def index
    @courses = Course.all
  end  

  def show
    #@enrolled = current_user.enrollments.map(&:course_id).include?(@course.id)
  end

  def new
    @course = Course.new
    @instructors = Instructor.all
  end

  def create
    @course = Course.new(course_params)
    
    if @course.save
      redirect_to @course, notice: t('.success')
    else
      @instructors = Instructor.all
      render :new
    end
  end

  def edit
    @instructors = Instructor.all
  end

  def update
    @course.update(course_params)
    redirect_to @course, notice: t('.success')
  end

  def destroy
    @course = Course.friendly.find(params[:id])
    @course.destroy
    redirect_to courses_path, notice: t('.success')
  end

  def enroll
    current_user.enrollments.create(course: @course, price: @course.price)
    redirect_to my_courses_courses_path, notice: 'Curso comprado com sucesso'
  end

  def my_courses
    @enrollments = current_user.enrollments
  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :enrollment_deadline, :price, :instructor_id)
  end
end