# == Schema Information
#
# Table name: solutions
#
#  id           :integer          not null, primary key
#  semester     :string(255)
#  name         :string(255)
#  csv          :text(4294967295)
#  created_at   :datetime
#  updated_at   :datetime
#  student_data :binary(16777216)
#  project_data :binary(16777216)
#

class Solution < ActiveRecord::Base
end
