class StudentsController < ApplicationController
  def new
  	@student = Student.new
  end

  def create
  	@student = Student.new(student_params)
  	if @student.save
  		redirect_to students_path
  	else
  		render 'new'
  	end
  end

  def index
  	@students = Student.all
  end

  private

  	def student_params
  		params.require(:student).permit(:email, :first_name, :last_name, :major, 
  			:availability, :semester)
  	end
end
