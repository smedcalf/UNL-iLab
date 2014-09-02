# == Schema Information
#
# Table name: student_preferences
#
#  id                        :integer          not null, primary key
#  student_id                :integer
#  project_id                :integer
#  rating                    :integer
#  created_at                :datetime
#  updated_at                :datetime
#  cover_letter_content_type :string(255)
#  cover_letter_file_name    :string(255)
#  cover_letter_file_size    :integer
#  resume_content_type       :string(255)
#  resume_file_name          :string(255)
#  resume_file_size          :integer
#  google_plus_url           :string(255)
#  github_url                :string(255)
#

class StudentPreference < ActiveRecord::Base
	belongs_to :project
	belongs_to :student

  has_one :sponsor, through: :project, source_type: "Sponsor"

  has_attached_file :cover_letter, :path => ":rails_root/public/:class/:attachment/:id/:basename.:extension", \
                    :url => Rails.env == "development"\
                    ? "/:class/:attachment/:id/:basename.:extension"
                    : "/UNL-iLab/:class/:attachment/:id/:basename.:extension"

  has_attached_file :resume, :path => ":rails_root/public/:class/:attachment/:id/:basename.:extension", \
                    :url => Rails.env == "development"\
                    ? "/:class/:attachment/:id/:basename.:extension"
                    : "/UNL-iLab/:class/:attachment/:id/:basename.:extension"
	do_not_validate_attachment_file_type :cover_letter
	do_not_validate_attachment_file_type :resume

  before_save :rename_cover_letter
  before_save :rename_resume

	validates :project_id, :resume, :cover_letter, presence: true
	validates :student_id, presence: true
	validates :rating, presence: true

  after_initialize :set_defaults

  def rename_cover_letter
    extension = File.extname(cover_letter_file_name).downcase
    self.cover_letter.instance_write :file_name, "#{self.student.full_name}-#{self.project.name}-CoverLetter#{extension}"
	end

  def rename_resume
    extension = File.extname(resume_file_name).downcase
    self.resume.instance_write :file_name, "#{self.student.full_name}-#{self.project.name}-Resume#{extension}"
  end

  private

  def set_defaults
    if self.new_record?
      self.github_url = "" if self.github_url.blank?
      self.google_plus_url = "" if self.google_plus_url.blank?
    end
  end
end
