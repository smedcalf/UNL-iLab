# == Schema Information
#
# Table name: auto_tokens
#
#  id         :integer          not null, primary key
#  token      :text
#  created_at :datetime
#  updated_at :datetime
#

class AutoToken < ActiveRecord::Base
end
