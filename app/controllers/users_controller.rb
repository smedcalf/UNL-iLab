class UsersController < ApplicationController
	before_action :signed_in_user, except: [:new]

	def new
		@user = User.new
		@url = "create"
	end

	def index
		@users = User.all
	end

	def show
		set_user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to user_path(@user.id)
		else
			render 'new'
		end
	end

	def edit
		set_user
		@url = "update"
	end

	def update
		set_user
		# To Do!
	end

	private

		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation)
		end

		def set_user
			@user = User.find_by_id(params[:id])
		end
end
