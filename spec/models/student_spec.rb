# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  email        :string(255)
#  first_name   :string(255)
#  last_name    :string(255)
#  major        :string(255)
#  semester     :string(255)
#  classname    :string(255)
#  availability :integer
#  status       :integer
#  created_at   :datetime
#  updated_at   :datetime
#  team_id      :integer
#  user_id      :integer
#

require 'spec_helper'

describe Student do

end
