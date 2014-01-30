class Instructor < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	
	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
