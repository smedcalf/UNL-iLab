FactoryGirl.define do

  sequence(:email) { |n| "email_#{n}@example.com" }


  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    utype ""
  end

  factory :sponsor do
    association :user, factory: :user, utype: "sponsor"
    sequence(:first_name) { |n| "First_#{n}" }
    last_name "Sponsor"
    email
  end

  factory :project do
    sponsor
    sequence(:name) { |n| "project_#{n}" }
    initial_capacity 4
    semester "Spring"
    proposal File.new(Rails.root.join("spec", "fixtures", "resume.txt"))
  end

  factory :student do
    association :user, factory: :user, utype: "student"
    sequence(:email) { |n| "student_#{n}@example.com" }
    sequence(:first_name) { |n| "First_#{n}" }
    last_name "Student"
    major "Computer Science"
    semester "Spring"
    classname "CSE498"
    availability 1
  end

  factory :team do
    project
    sequence(:name) { |n| "Team #{n}" }
  end
end
