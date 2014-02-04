module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		if user.remember_tokens.nil?
			remember_tokens = []
		else
			remember_tokens = user.remember_tokens.split("|")
		end
		remember_tokens.push User.encrypt(remember_token)
		user.update_attribute(:remember_tokens, remember_tokens.join("|") )
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.where("remember_tokens LIKE ?", "%#{remember_token}%").first
	end

	def sign_out
		remember_tokens = current_user.remember_tokens.split("|")
		remember_token = cookies[:remember_token]
		remember_tokens.delete User.encrypt(remember_token)
		current_user.update_attribute(:remember_tokens, remember_tokens.join("|") )
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def signed_in_user
		unless signed_in?
			redirect_to login_path
		end
	end
end
