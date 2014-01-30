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

	def edit
		set_instructor
		@url = "update"
	end

	def show
		set_instructor
	end

	def update
		set_instructor
		@url = "update"
		if @instructor.update_attributes(instructor_params)
			redirect_to instructor_path(@instructor.id)
		else
			render 'edit'
		end
	end

	private

			def instructor_params
				params.require(:instructor).permit(:email, :classname, :semester,
					:first_name, :last_name)
			end

			def set_instructor
				@instructor = Instructor.find_by_id(params[:id])
			end
end
