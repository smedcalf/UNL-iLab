# == Schema Information
#
# Table name: student_preferences
#
#  id         :integer          not null, primary key
#  student_id :integer
#  project_id :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#

class StudentPreference < ActiveRecord::Base
	has_one :project
	has_one :student

	validates :project_id, presence: true
	validates :student_id, presence: true
	validates :rating, presence: true

  def student
    Student.find(self.student_id)
  end

  def project
    Project.find(self.project_id)
  end
end
