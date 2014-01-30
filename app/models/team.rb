class Team < ActiveRecord::Base
	belongs_to :project
	has_many :students

	validates :name, presence: true
end
