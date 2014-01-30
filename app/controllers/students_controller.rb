class StudentsController < ApplicationController
  def new
  	@student = Student.new
    @url = "create"
  end

  def create
  	@student = Student.new(student_params)
  	if @student.save
  		redirect_to students_path
  	else
  		render 'new'
  	end
  end

  def show
    set_student
  end

  def edit
    set_student
    @url = "update"
  end

  def index
  	@students = Student.all
    @teams = Team.all.sort_by { |t| t.name }
  end

  def update
    set_student
    @url = "update"
    if @student.update_attributes(student_params)
      redirect_to student_path(@student.id)
    else
      render 'edit'
    end
  end

  private

  	def student_params
  		params.require(:student).permit(:email, :first_name, :last_name, :major, 
  			:availability, :semester)
  	end

    def set_student
      @student = Student.find_by_id(params[:id])
    end
end
