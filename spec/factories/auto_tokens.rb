# == Schema Information
#
# Table name: auto_tokens
#
#  id         :integer          not null, primary key
#  token      :text
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auto_token do
  end
end
