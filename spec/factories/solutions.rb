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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :solution do
  end
end
