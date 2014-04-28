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
#  email           :string(255)
#

class User < ActiveRecord::Base
	has_secure_password

	# Really only has one of these
	has_one :student, dependent: :destroy
	has_one :instructor, dependent: :destroy
	has_one :sponsor, dependent: :destroy
  has_many :events, dependent: :destroy

	validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, :uniqueness => true
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def instructor?
		 self.utype == "instructor" || self.utype == "admin"
	end

	def student?
		self.utype == "student"
	end

	def sponsor?
		self.utype == "sponsor"
  end

  def profile
    if instructor?
      self.instructor
    elsif sponsor?
      self.sponsor
    else
      self.student
    end
  end
end
