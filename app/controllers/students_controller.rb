class StudentsController < ApplicationController
  before_action :signed_in_user

  def new
  	@student = Student.new
    @url = "create"
  end

  def create
  	@student = Student.new(student_params)
    #if current_user.utype == "student"
      @student.user_id = current_user.id
    #end
  	if @student.save
      flash[:success] = 'Congratulations!!! New student was created successfully!'
      if current_user.student?
        redirect_to student_path(@student.id)
      else
  		  redirect_to students_path
      end
  	else
      flash.now[:error] = @student.errors.full_messages
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

  def destroy
    Student.destroy(params[:student])
    redirect_to students_path
  end

  def apply
    @projects = Project.all
  end

  private

  	def student_params
  		params.require(:student).permit(:email, :first_name, :last_name, :major,
  			:availability, :semester, :classname, :avatar)
  	end

    def set_student
      @student = Student.find_by_id(params[:id])
    end
end
