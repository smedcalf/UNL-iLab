# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  project_id   :integer
#  google_drive :string(255)
#  trello_link  :string(255)
#

require 'spec_helper'

describe Team do
  before do
    @team = Team.new(name: "Test")
  end

  subject { @team }

  it { should respond_to(:name) }
  it { should respond_to(:students) }
  it { should respond_to(:project) }

  it { should be_valid }

  describe "name" do
    let(:another_team) { FactoryGirl.create(:team) }

    before do
      @team.save
    end

    it "should be unique" do
      another_team.name = "Test"
      expect(another_team.save).to eql(false)
    end

    it "should be present" do
      another_team.name = " "
      expect(another_team.save).to eql(false)
    end
  end

  describe "#has_user?" do
    let(:student_one) { FactoryGirl.create(:student) }
    let(:random_user) { FactoryGirl.create(:student) }

    before do
      @team.students << student_one
      @team.save
    end

    it "should return false if user is not in team" do

      expect(@team.has_user?(random_user.user)).to eql(false)
    end

    it "should return true if user is in team" do
      expect(@team.has_user?(student_one.user)).to eql(true)
    end
  end
end
