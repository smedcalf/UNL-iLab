# == Schema Information
#
# Table name: projects
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  initial_capacity      :integer
#  sponsor_id            :integer
#  sponsor_type          :string(255)
#  current_capacity      :integer
#  semester              :string(255)
#  proposal_file_name    :string(255)
#  proposal_content_type :string(255)
#  proposal_file_size    :integer
#  active                :boolean
#  status                :boolean
#  created_at            :datetime
#  updated_at            :datetime
#
# Indexes
#
#  index_projects_on_sponsor_id_and_sponsor_type  (sponsor_id,sponsor_type)
#

require 'spec_helper'

describe Project do
  let(:sponsor) { FactoryGirl.create(:sponsor) }

  before do
    @project = Project.new(name: "Lemur Works", initial_capacity: 4, semester: "Fall",
                           sponsor: sponsor)
  end

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:initial_capacity) }
  it { should respond_to(:sponsor) }
  it { should respond_to(:current_capacity) }
  it { should respond_to(:semester) }
  it { should respond_to(:proposal) }
  it { should respond_to(:active) }
  it { should respond_to(:status) }

  it { should be_valid }

  describe "name should be present" do
    before do
      @project.name = " "
    end

    it { should_not be_valid }
  end

  describe "intial_capacity should be present" do
    before do
      @project.initial_capacity = nil
    end

    it { should_not be_valid }
  end

  describe "semester should be present" do
    before do
      @project.semester = " "
    end

    it { should_not be_valid }
  end

  describe "sponsor should be present" do
    before do
      @project.sponsor = nil
    end

    it { should_not be_valid }
  end

  describe "#set_defaults" do
    before do
      @p = Project.new
    end

    it "should be initialized to correct defaults" do
      @p.send(:set_defaults)

      expect(@p.initial_capacity).to eql(4)
      expect(@p.current_capacity).to eql(4)
      expect(@p.active).to eql(false)
      expect(@p.status).to eql(false)
    end
  end
end
