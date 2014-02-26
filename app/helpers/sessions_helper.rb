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

	def student?
		current_user.student?
	end

	def sponsor?
		current_user.sponsor?
	end

	def instructor?
		current_user.instructor?
	end

	def signed_in_user
		unless signed_in?
			redirect_to root_url
		end
	end

	def signed_in_instructor
		unless current_user.instructor? || current_user.utype == "admin"
			not_found
		end
	end

	def signed_in_student
		unless  current_user.student?
			not_found
		end
	end

	def signed_in_sponsor
		unless current_user.sponsor?
			not_found
		end
	end

	def current_instructor?(id)
		if current_user.instructor? && current_user.instructor.id == id
			true
		else
			false
		end
	end

	def current_student?(id)
		if current_user.student? && current_user.student.id == id
			true
		else
			false
		end
	end

	def current_sponsor?(id)
		if current_user.sponsor? && current_user.sponsor.id == id
			true
		else
			false
		end
	end

	def correct_instructor
		unless (current_user.instructor? &&
			current_user.instructor.id.to_s == params[:id])
			not_found
		end
	end

	def correct_student
		unless (current_user.student? &&
			current_user.student.id.to_s == params[:id])
			not_found
		end
	end

	def correct_sponsor
		unless (current_user.instructor? &&
			current_user.sponsor.id.to_s == params[:id])
			not_found
		end
	end
end
