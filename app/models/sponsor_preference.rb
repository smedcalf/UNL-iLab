# == Schema Information
#
# Table name: sponsor_preferences
#
#  id         :integer          not null, primary key
#  student_id :integer
#  project_id :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#

class SponsorPreference < ActiveRecord::Base
  belongs_to :project
  belongs_to :student
  has_one :sponsor, through: :project, source_type: "Sponsor"

  validates :project_id, presence: true
  validates :student_id, presence: true
  validates :rating, presence: true
end
