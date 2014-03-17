# == Schema Information
#
# Table name: projects
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  initial_capacity      :integer
#  sponsor_id            :integer
#  sponsor_type          :string(255)
#  current_capacity      :integer
#  semester              :string(255)
#  proposal_file_name    :string(255)
#  proposal_content_type :string(255)
#  proposal_file_size    :integer
#  active                :boolean
#  status                :boolean
#  created_at            :datetime
#  updated_at            :datetime
#
# Indexes
#
#  index_projects_on_sponsor_id_and_sponsor_type  (sponsor_id,sponsor_type)
#

class Project < ActiveRecord::Base
  belongs_to :sponsor, polymorphic: true
  has_many :team, dependent: :destroy
  has_many :student_preferences, dependent: :destroy
  has_many :sponsor_preferences, dependent: :destroy

  validates :name, :initial_capacity, :semester, :sponsor_id, :presence => true
  validates :name, :uniqueness => true

  after_initialize :set_defaults

  has_attached_file :proposal


  def sponsor
    Sponsor.find(self.sponsor_id)
  end

  private
  def set_defaults
    if self.new_record?
      self.initial_capacity = 4 if self.initial_capacity.blank?
      self.current_capacity = self.initial_capacity
      self.active = 0 if self.active.blank?
      self.status = 0 if self.status.blank?
    end
  end


end
