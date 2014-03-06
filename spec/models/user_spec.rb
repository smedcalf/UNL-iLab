# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  utype           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  remember_tokens :string(255)
#

require 'spec_helper'

describe User do

end
