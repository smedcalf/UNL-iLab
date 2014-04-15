class SessionsController < ApplicationController

  before_action :sign_in_cse, only: :create
  require 'net/http'

	def new
		if signed_in?
			redirect_to user_path(current_user.id)
		end
	end

	def create
    user = User.find_by(name: params[:session][:name].downcase)
		if !user.nil? && params[:session][:name] && params[:session][:password]

			if user && user.authenticate(params[:session][:password])
				sign_in user
				redirect_to user_path(current_user.id)
      else
        flash[:error] = "Invalid Username/Password"
				redirect_to root_url
      end
    elsif @course != ""
      @email = "#{params[:session][:name]}@cse.unl.edu"
      @pwd = params[:session][:password]
      @user = User.new(:name => params[:session][:name], :email => @email,
                       :password => @pwd, :password_confirmation => @pwd, :utype => "student")
      if @user.valid?
        @user.save
        sign_in @user
        redirect_to user_path(:id => current_user.id)
      else
        flash[:error] = "Invalid Username/Password"
        redirect_to :back
      end
    else
      flash[:error] = "Invalid Username/Password"
			redirect_to root_url
    end
	end

	def destroy
		sign_out
		redirect_to root_url
  end

  def reset_password
  end

  def temporary_password
    @user = User.where(:name => params[:session][:name], :email => params[:session][:email]).first
    if @user.nil?
      flash[:error] = "Invalid username or email"
    else
      @pwd = SecureRandom.hex(4)
      @user.password = @pwd
      @user.password_confirmation = @pwd
      if @user.save
        flash[:success] = "Temporary password was sent to your mailbox, please check out."
        UserMailer.reset_password_confirmation(@user, @pwd).deliver
      end
    end
    redirect_to :back
  end

end
