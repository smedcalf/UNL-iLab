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

require 'spec_helper'

describe Student do

end
