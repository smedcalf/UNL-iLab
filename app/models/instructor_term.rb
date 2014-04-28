# == Schema Information
#
# Table name: instructor_terms
#
#  id            :integer          not null, primary key
#  instructor_id :integer
#  semester      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_instructor_terms_on_instructor_id  (instructor_id)
#

class InstructorTerm < ActiveRecord::Base
  belongs_to :instructor

  validates :instructor_id, :semester, presence: true
end
