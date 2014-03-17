class StudentsController < UsersController
  before_action :signed_in_user

  def new
  	@student = Student.new
    @url = "create"
  end

  def create
    @pwd = SecureRandom.hex(4)
    @user = User.new(:name => params[:student][:email], :email => params[:student][:email],
                     :password => @pwd, :password_confirmation => @pwd, :utype => "student")
    @student = Student.new(student_params)
    if @user.valid?
      if current_user.utype == "student"
        @student.user_id = current_user.id
      else
        @student.user_id = @user.id
      end
      if @student.valid?
        @user.save
        @student.save
        flash[:success] = "Congratulations!!! New student was created successfully!<br/> Username: #{@user.name} <br/> Password: #{@pwd}"
        if current_user.student?
          redirect_to student_path(@student.id)
        else
          redirect_to students_path
        end
      else
        flash.now[:error] = @student.errors.full_messages.join(", ").html_safe
        render 'new'
      end
    else
      flash.now[:error] = @user.errors.full_messages.join(", ").html_safe
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
