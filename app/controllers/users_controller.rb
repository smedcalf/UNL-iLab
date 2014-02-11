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
