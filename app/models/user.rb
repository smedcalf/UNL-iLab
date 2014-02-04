class User < ActiveRecord::Base
	has_secure_password

	validates :name, presence: true, uniqueness: { case_sensitive: false} 
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
end
