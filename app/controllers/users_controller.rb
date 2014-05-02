class UsersController < ApplicationController
	before_action :signed_in_user, except: [:new, :create]
	before_action :correct_user, only: [:edit, :update]

	def new
		@user = User.new
		@url = "create"
	end

  def manage_users
    if params[:user].nil?
      flash[:error] = "No user was selected."
      redirect_to users_path
    else
      case params[:commit]
        when 'delete'
          User.destroy(params[:user])
          flash[:success] = "Selected users have been removed."
        when 'assign'
					if acceptable_utype
          	User.where(:id => params[:user]).update_all(:utype => params[:utype])
            @user = User.find(params[:user])
            flash[:success] = "User type has been successfully assigned."
            UserMailer.user_type_confirmation(@user.first).deliver
					end
      end
      redirect_to users_path
    end
  end

  def index
		@users = User.all
	end

	def show
		set_user

		if @user.student?
      if @user.student.nil?
        redirect_to new_student_path
      else
			  redirect_to student_path(@user.student.id)
      end
    elsif @user.instructor?
      if @user.instructor.nil?
			  redirect_to new_instructor_path
      else
        redirect_to instructor_path(@user.instructor.id)
      end
    elsif @user.sponsor?
      if @user.sponsor.nil?
        redirect_to new_sponsor_path
      else
        redirect_to sponsor_path(@user.sponsor.id)
      end
		else
			render 'show'
		end
  end

  # def edit
	# 	if current_user.student?
	# 		redirect_to edit_student_path(current_user.student.id)
	# 	elsif current_user.sponsor?
	# 		redirect_to edit_sponsor_path(current_user.sponsor.id)
	# 	elsif current_user.instructor?
	# 		redirect_to edit_instructor_path(current_user.instructor.id)
	# 	else
	# 		redirect_to edit_user_path(current_user)
	# 	end
  # end

	def create
		@user = User.new(user_params)

		unless User.any?
			@user.utype = "admin"
		end

		if @user.save
      UserMailer.registration_confirmation(@user).deliver
			redirect_to user_path(@user.id)
			if @user.utype == "instructor"
  	    flash[:success] = 'Account has been created and you are set to an instructor(admin)'
			else
				flash[:success] = 'Congratulations!!! Your account has been created!'
			end
      sign_in(@user)
    else
      flash[:error] = @user.errors.full_messages.join(", ").html_safe
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

  def reset_password

  end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def set_user
			@user = User.find_by_id(params[:id])
		end

		def acceptable_utype
			if (params[:utype] == "admin" ||
          params[:utype] == "instructor" ||
          params[:utype] == "student" ||
          params[:utype] == "sponsor")
				return true
			end
			false
		end
end
