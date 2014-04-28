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

require 'spec_helper'

describe InstructorTerm do
  pending "add some examples to (or delete) #{__FILE__}"
end
