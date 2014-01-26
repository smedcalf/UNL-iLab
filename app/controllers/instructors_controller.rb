class InstructorsController < ApplicationController

	def new
		@instructor = Instructor.new
	end

	def index
		@instructors = Instructor.all
	end

	def create
		@instructor = Instructor.new(instructor_params)
		if @instructor.save
			redirect_to instructors_path
		else
			render 'new'
		end
	end

	private

			def instructor_params
				params.require(:instructor).permit(:email, :classname, :semester,
					:first_name, :last_name)
			end
end
