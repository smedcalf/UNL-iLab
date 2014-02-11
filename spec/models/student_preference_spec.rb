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

require 'spec_helper'

describe StudentPreference do
  pending "add some examples to (or delete) #{__FILE__}"
end
