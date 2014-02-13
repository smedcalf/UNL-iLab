class SessionsController < ApplicationController
	def new
		if signed_in?
			redirect_to user_path(current_user.id)
		end
	end

	def create
		if params[:session][:name] && params[:session][:password]
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
end
