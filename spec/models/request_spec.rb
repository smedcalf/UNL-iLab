# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  student_id :integer
#  start_date :datetime
#  end_date   :datetime
#  approved   :boolean
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Request do
  pending "add some examples to (or delete) #{__FILE__}"
end
