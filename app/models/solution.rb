# == Schema Information
#
# Table name: solutions
#
#  id         :integer          not null, primary key
#  semester   :string(255)
#  name       :string(255)
#  csv        :text
#  created_at :datetime
#  updated_at :datetime
#

class Solution < ActiveRecord::Base
end
