# == Schema Information
#
# Table name: students
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  major               :string(255)
#  semester            :string(255)
#  classname           :string(255)
#  availability        :integer
#  status              :integer
#  created_at          :datetime
#  updated_at          :datetime
#  team_id             :integer
#  user_id             :integer
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'spec_helper'
require 'paperclip/matchers'

describe Student do

  before do
    @student = Student.new(email: "student@example.com", first_name: "Test",
                        last_name: "Student", major: "Computer Science",
                        semester: "Fall", classname: "CSE 491", availability: 1)
  end

  subject { @student }

  it { should respond_to(:email) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:major) }
  it { should respond_to(:semester) }
  it { should respond_to(:availability) }
  it { should respond_to(:avatar) }
  it { should respond_to(:user) }
  it { should respond_to(:team) }

  it { should be_valid }

  describe "when email is not present do" do
    before { @student.email = " " }

    it { should_not be_valid }
  end

  describe "when first_name is not present" do
    before { @student.first_name = " " }

    it { should_not be_valid }
  end

  describe "when last_name is not present" do
    before { @student.last_name = " " }

    it { should_not be_valid }
  end

  describe "when major is not present" do
    before { @student.major = " " }

    it { should_not be_valid }
  end

  describe "when semester is not present" do
    before { @student.semester = " " }

    it { should_not be_valid }
  end

  describe "when classname is not present" do
    before { @student.classname = " " }

    it { should_not be_valid }
  end

  describe "when availability is not present" do
    before { @student.availability = nil }

    it { should_not be_valid }
  end

  describe "full name" do

    it "should return the full name of the student" do
      expect(@student.full_name).to eql("Test Student")
    end
  end

  describe "avatar url" do

    describe "when avatar present" do
      before do
        @student.avatar = File.new(File.join(Rails.root, 'spec', 'fixtures', 'student_portrait.jpg'))
        @student.save
      end

      it "should give back a url" do
        expect(@student.avatar_url).to match(/.+student_portrait\.jpg.+/)
      end
    end

    describe "when avatar isn't present" do

      it "should show a cute kitten" do
        expect(@student.avatar_url).to match(/http:\/\/placekitten.com\/(\d)+\/(\d)+/)
      end
    end
  end
end
