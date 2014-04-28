# == Schema Information
#
# Table name: instructor_terms
#
#  id            :integer          not null, primary key
#  instructor_id :integer
#  semester      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_instructor_terms_on_instructor_id  (instructor_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instructor_term do
    instructor nil
    semester "MyString"
  end
end
