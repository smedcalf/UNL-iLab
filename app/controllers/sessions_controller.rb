class SessionsController < ApplicationController
  require 'net/http'

	def new
		if signed_in?
			redirect_to user_path(current_user.id)
		end
	end

	def create

    token = "DDFEFE94-87E1-484A-B5CC-DC6145CFBF13"
    cse_url = URI.parse("https://cse-apps.unl.edu/cseauth/auth/authenticate?" +
                        "token=#{token}&" +
                        "username=#{params[:session][:name]}&" +
                        "password=#{params[:session][:password]}")
    req = Weary::Request.new cse_url.to_s, :GET
    result = req.perform do |res|
      res.body
    end
    if result.body == "success"
      # Check for user
      if User.find_by_name(params[:session][:name]).nil?
        @email = "#{params[:session][:name]}@cse.unl.edu"
        @pwd = params[:session][:password]
        @user = User.new(:name => params[:session][:name], :email => @email,
                         :password => @pwd, :password_confirmation => @pwd, :utype => "student")
        if @user.valid?
          @user.save
          sign_in @user
          redirect_to user_path(current_user.id)
        else
          redirect_to :back
        end

      else
        user = User.find_by(name: params[:session][:name].downcase)
        sign_in user
        redirect_to user_path(current_user.id)
      end

		elsif params[:session][:name] && params[:session][:password]
			user = User.find_by(name: params[:session][:name].downcase)
			if user && user.authenticate(params[:session][:password])
				sign_in user
				redirect_to user_path(current_user.id)
			else
				redirect_to root_url
			end
		else
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
