# == Schema Information
#
# Table name: auth_tokens
#
#  id         :integer          not null, primary key
#  token      :text
#  created_at :datetime
#  updated_at :datetime
#

class AuthToken < ActiveRecord::Base
end
