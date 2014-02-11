class UsersController < ApplicationController
	before_action :signed_in_user, except: [:new, :create]

	def new
		@user = User.new
		@url = "create"
	end

  def manage_users
    case params[:commit]
      when 'delete'
        User.destroy(params[:user])
      when 'assign'
        User.where(:id => params[:user]).update_all(:type => params[:type])
    end
    redirect_to users_path
  end

  def index
		@users = User.all
	end

	def show
		set_user
  end

  def home

  end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to user_path(@user.id)
      flash[:success] = 'Congratulations!!! Your account has been created!'
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
