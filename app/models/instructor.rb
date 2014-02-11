# == Schema Information
#
# Table name: instructors
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  classname  :string(255)
#  semester   :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Instructor < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	
	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
