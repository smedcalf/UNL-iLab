# == Schema Information
#
# Table name: solutions
#
#  id           :integer          not null, primary key
#  semester     :string(255)      not null
#  name         :string(255)      not null
#  csv          :text(2147483647) not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  student_data :binary(214748364
#  project_data :binary(214748364
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :solution do
  end
end
