class UsersController < ApplicationController
	before_action :signed_in_user, except: [:new, :create]

	def new
		@user = User.new
		@url = "create"
	end

  def manage_users
    if params[:user].nil?
      flash[:error] = "No sutdent was selected."
      redirect_to users_path
    else
      case params[:commit]
        when 'delete'
          User.destroy(params[:user])
        when 'assign'
          User.where(:id => params[:user]).update_all(:utype => params[:utype])
      end
      redirect_to users_path
    end
  end

  def index
		@users = User.all
	end

	def show
		set_user
		case @user.utype
      when "student"
        if @user.student.nil?
          redirect_to new_student_path
        else
          redirect_to student_path(@user.student.id)
        end
      when "instructor"
        redirect_to instructor_path(@user.instructor.id)
      when "sponsor"
        redirect_to sponsor_path(@user.sponsor.id)
      else
        render 'show'
		end
  end

  def edit_profile
    if current_user.utype.nil?
      redirect_to edit_user_path(current_user)
    else
      case current_user.utype
        when 'instructor'
          if current_user.instructor.nil?
            redirect_to new_instructor_path
          else
            redirect_to edit_instructor_path(current_user.instructor.id)
          end
        when 'sponsor'
          if current_user.sponsor.nil?
            redirect_to new_sponsor_path
          else
            redirect_to edit_sponsor_path(current_user.sponsor.id)
          end
        when 'student'
          if current_user.student.nil?
            redirect_to new_student_path
          else
            redirect_to edit_student_path(current_user.student.id)
          end
        else
          redirect_to edit_user_path(current_user)
      end
    end
  end

	def create
		@user = User.new(user_params)
		
		unless User.any?
			@user.utype = "instructor"
		end

		if @user.save
			redirect_to user_path(@user.id)
			if @user.utype == "instructor"
  	    flash[:success] = 'Account has been created and you are set to an instructor(admin)'
			else
				flash[:success] = 'Congratulations!!! Your account has been created!'
			end
      sign_in(@user)
    else
      redirect_to :back
		end
	end

	def edit
		set_user
		@url = "update"
	end

	def update
		set_user
		@url = 'update'
		if @user.authenticate(params[:user][:old_password])
			@user.password = params[:user][:password]
			@user.password_confirmation = params[:user][:password_confirmation]
			if @user.save
				flash[:success] = "Password changed"
				redirect_to user_path(@user.id)
			else
				flash.now[:error] = "Password and Confirmation did not match"
				render 'edit'
			end
		else
			flash.now[:error] = "Password was wrong"
			render 'edit'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation)
		end

		def set_user
			@user = User.find_by_id(params[:id])
		end
end
