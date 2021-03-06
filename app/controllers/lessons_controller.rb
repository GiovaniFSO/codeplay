class LessonsController < ApplicationController
  before_action :set_course, only: %i[new create]
  before_action :set_lesson, only: %i[show]
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.create!(lesson_params)    
    redirect_to course_path(@course), notice: 'Aula cadastrada com sucesso'
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_course
    @course = Course.friendly.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :duration, :content)
  end
end