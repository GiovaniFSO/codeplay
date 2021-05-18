class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  def index
    @instructors = Instructor.all
  end  

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      redirect_to @instructor, notice: "#{@instructor.name} salvo com sucesso!"
    else
      flash.now[:alert] = @instructor.errors.full_messages
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @instructor.update(instructor_params)
      redirect_to @instructor
    else
      render :new
    end
  end

  def destroy
    if @instructor.destroy
      redirect_to instructors_path
    end
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :profile_picture, :bio)
  end
end