# == Schema Information
#
# Table name: instructors
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  classname  :string(255)
#  semester   :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe Instructor do
  pending "add some examples to (or delete) #{__FILE__}"
end
