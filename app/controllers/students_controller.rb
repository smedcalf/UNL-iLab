class StudentsController < ApplicationController
  before_action :signed_in_user
  before_action :instructor?, only: [:index]
  before_action :correct_student || :correct_instructor, only: [:edit, :update]

  #!TODO previous_students
  def past_students
    if current_user.utype == "admin"
      @students = Student.all.where(['status < ?', 0])
    else
      @students = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Student.where(:semester => it.semester, :status => -1).each do |s|
          @students << s
        end
      end
    end
  end

  def new
  	@student = Student.new
    if !current_user.instructor?
      @student.email = current_user.email
    end
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
      @user = User.new(:name => params[:student][:email].partition("@").first, :email => params[:student][:email],
                       :password => @pwd, :password_confirmation => @pwd, :utype => "student")
      @student = Student.new(student_params)
      if @user.valid?
        if @student.valid?
          @user.save
          @student.user_id = @user.id
          flash[:success] = "Congratulations!!! New student was created successfully! Username: #{@user.name}  Password: #{@pwd}"
          @student.save
          UserMailer.user_account_confirmation(@user, @pwd).deliver
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
    if current_user.utype == "admin"
      @students = Student.all.where(['status >= ?', 0])
    else
      @students = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Student.where("semester = '#{it.semester}' AND status >= 0").each do |s|
          @students << s
        end
      end
    end
  end

  def update
    set_student
    @url = "update"
    if @student.update_attributes(student_params)
      flash[:success] = "Student profile was updated."
      redirect_to student_path(@student.id)
    else
      flash[:error] = @student.errors.full_messages.join(", ").html_safe
      render 'edit'
    end
  end

  def manage_students
    if params[:student].nil?
      flash[:error] = 'No student was selected!'
      redirect_to students_path
    else
      case params[:commit]
        when 'delete'
          Student.destroy(params[:student])
          flash[:success] = "Selected Students were deleted."
          redirect_to students_path
        when 'deactivate'
          Student.where(:id => params[:student]).update_all(:status => -1)
          flash[:success] = "Selected Students were deactivated, please check past students"
          redirect_to past_students_students_path
        when 'reactivate'
          Student.where(:id => params[:student]).update_all(:status => 0)
          flash[:success] = "Selected Students were reactivated, please check current students"
          redirect_to students_path
        when 'disable'
          Student.where(:id => params[:student]).update_all(:status => 1)
          flash[:success] = "Selected Students were disabled."
          redirect_to students_path
        when 'enable'
          Student.where(:id => params[:student]).update_all(:status => 0)
          flash[:success] = "Selected Students were enabled."
          redirect_to students_path
        when 'unassign'
          Student.where(:id => params[:student]).update_all(:team_id => nil)
          flash[:success] = "Selected Students were unassigned."
          redirect_to students_path
      end
    end
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
