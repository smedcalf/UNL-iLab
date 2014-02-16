# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  project_id   :integer
#  google_drive :string(255)
#

class Team < ActiveRecord::Base
	belongs_to :project
	has_many :students

	validates :name, presence: true, uniqueness: true
end
