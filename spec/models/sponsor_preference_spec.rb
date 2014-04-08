# == Schema Information
#
# Table name: sponsor_preferences
#
#  id         :integer          not null, primary key
#  student_id :integer
#  project_id :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe SponsorPreference do
  let(:user) { FactoryGirl.create(:user) }
  let(:student) { FactoryGirl.create(:student, user: user) }
  let(:project) { FactoryGirl.create(:project) }

  before do
    @sp = SponsorPreference.new(student: student, project: project, rating: 4)
  end

  subject { @sp }

  it { should respond_to(:student) }
  it { should respond_to(:project) }
  it { should respond_to(:rating) }

  it { should be_valid }

  describe "student should be present" do
    before do
      @sp.student = nil
    end

    it { should_not be_valid }
  end

  describe "project should be present" do
    before do
      @sp.project = nil
    end

    it { should_not be_valid }
  end
end
