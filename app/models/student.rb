# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  email        :string(255)
#  first_name   :string(255)
#  last_name    :string(255)
#  major        :string(255)
#  semester     :string(255)
#  classname    :string(255)
#  availability :integer
#  status       :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Student < ActiveRecord::Base

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
