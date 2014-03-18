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
#

require 'spec_helper'

describe StudentPreference do

end
