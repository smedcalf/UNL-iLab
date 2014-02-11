# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  utype           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  remember_tokens :string(255)
#

class User < ActiveRecord::Base
	has_secure_password

	# Really only has one of these
	has_one :student
	has_one :instructor
	has_one :sponsor

	validates :name, presence: true, uniqueness: { case_sensitive: false} 
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
end
