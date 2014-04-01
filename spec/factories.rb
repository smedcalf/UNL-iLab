FactoryGirl.define do

  sequence(:email) { |n| "email_#{n}@example.com" }

  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :sponsor do
    user
    sequence(:first_name) { |n| "First_#{n}" }
    last_name "Sponsor"
    email
  end

  factory :project do
    sponsor
    sequence(:name) { |n| "project_#{n}" }
    initial_capacity 4
    semester "Spring"
  end

  factory :student do
    user
    sequence(:email) { |n| "student_#{n}@example.com" }
    sequence(:first_name) { |n| "First_#{n}" }
    last_name "Student"
    major "Computer Science"
    semester "Spring"
    classname "CSE498"
    availability 1
  end
end
