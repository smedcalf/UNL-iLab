# == Schema Information
#
# Table name: instructors
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  classname  :string(255)
#  semester   :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe Instructor do

  before do
    @instructor = Instructor.new(first_name: "Test", last_name: "Instructor", email: "test@instructor.com")
  end

  subject { @instructor }

  it { should respond_to(:email) }
  it { should respond_to(:classname) }
  it { should respond_to(:semester) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "first_name should be present" do
    before do
      @instructor.first_name = ""
    end

    it { should_not be_valid }
  end

  describe "last_name should be present" do
    before do
      @instructor.last_name = ""
    end

    it { should_not be_valid }
  end

  describe "email should be present" do
    before do
      @instructor.email = ""
    end

    it { should_not be_valid }
  end

  describe "full name" do
    it "should be first_name + last_name" do
      expect(@instructor.full_name).to eql("Test Instructor")
    end
  end
end
