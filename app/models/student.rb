# == Schema Information
#
# Table name: students
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  major               :string(255)
#  semester            :string(255)
#  classname           :string(255)
#  availability        :integer
#  status              :integer
#  created_at          :datetime
#  updated_at          :datetime
#  team_id             :integer
#  user_id             :integer
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Student < ActiveRecord::Base
	belongs_to :team
	belongs_to :user
	has_many :student_preferences, dependent: :destroy
  has_many :sponsor_preferences, dependent: :destroy
  has_one :request

	validates :email, :first_name, :last_name,  :major,
            :semester, :classname, :availability, presence: true

  has_attached_file :avatar
	do_not_validate_attachment_file_type :avatar

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def team_name
		if self.team
			self.team.name
		else
			""
		end
	end

	def avatar_url
		unless self.avatar.exists?
			# Add some fun and get unique kittens if picture is missing
			pixels = self.full_name.hash % 150
			"http://placekitten.com/#{150 + pixels}/#{150 + pixels}"
		else
			self.avatar.url
		end
  end

  private

    def set_defaults
      if self.new_record?
        self.status = 0 if self.status.blank?
      end
    end
end
