class StudentsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_student, only: [:edit, :update]

  def new
  	@student = Student.new
    @url = "create"
  end

  def create
    if current_user.utype == "student"

      @student = Student.new(student_params)
      @student.user_id = current_user.id
      if @student.valid?
        @student.save
        flash[:success] = "Congratulations!!! Your profile was created."
        redirect_to student_path(@student.id)
      else
        flash.now[:error] = @student.errors.full_messages.join(", ").html_safe
        render 'new'
      end

    else

      @pwd = SecureRandom.hex(4)
      @user = User.new(:name => params[:student][:email], :email => params[:student][:email],
                       :password => @pwd, :password_confirmation => @pwd, :utype => "student")
      @student = Student.new(student_params)
      if @user.valid?
        @student.user_id = @user.id
        if @student.valid?
          @user.save
          flash[:success] = "Congratulations!!! New student was created successfully! Username: #{@user.name}  Password: #{@pwd}"
          @student.save
          redirect_to students_path
        else
          flash.now[:error] = @student.errors.full_messages.join(", ").html_safe
          render 'new'
        end
      else
        flash.now[:error] = @user.errors.full_messages.join(", ").html_safe
        render 'new'
      end
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
