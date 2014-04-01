# == Schema Information
#
# Table name: student_preferences
#
#  id                        :integer          not null, primary key
#  student_id                :integer
#  project_id                :integer
#  rating                    :integer
#  created_at                :datetime
#  updated_at                :datetime
#  cover_letter_content_type :string(255)
#  cover_letter_file_name    :string(255)
#  cover_letter_file_size    :integer
#  resume_content_type       :string(255)
#  resume_file_name          :string(255)
#  resume_file_size          :integer
#

require 'spec_helper'

describe StudentPreference do
  let(:user) { FactoryGirl.create(:user) }
  let(:student) { FactoryGirl.create(:student, user: user) }
  let(:project) { FactoryGirl.create(:project) }

  before do
    @sp = StudentPreference.new(student: student, project: project, rating: 4,
      resume: File.new(Rails.root.join("spec", "fixtures", "resume.txt")),
      cover_letter: File.new(Rails.root.join("spec", "fixtures", "cover_letter.txt")))
  end

  subject { @sp }

  it { should respond_to(:student) }
  it { should respond_to(:project) }
  it { should respond_to(:rating) }
  it { should respond_to(:cover_letter) }
  it { should respond_to(:resume) }

  describe "cover letter" do
    before do
      @sp.save
    end


    it "should be renamed to correct format" do

      expect(@sp.cover_letter_file_name).to eql("#{@sp.student.full_name}-#{@sp.project.name}-CoverLetter.txt")
    end
  end

  describe "rename resume" do
    before do
      @sp.save
    end


    it "should be renamed to correct format" do

      expect(@sp.resume_file_name).to eql("#{@sp.student.full_name}-#{@sp.project.name}-Resume.txt")
    end
  end
end
