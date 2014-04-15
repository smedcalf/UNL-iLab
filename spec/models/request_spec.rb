# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  student_id :integer
#  start_date :datetime
#  end_date   :datetime
#  approved   :boolean
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Request do

  before do
    @request = Request.new(start_date: DateTime.now, end_date: DateTime.now + 1.hour)
  end

  subject { @request }

  it { should respond_to(:student) }
  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:approved) }
  it { should respond_to(:active) }

  it { should be_valid }

  describe "#setDefaults" do
    before do
      @r = Request.new(start_date: DateTime.now, end_date: DateTime.now + 1.hour)
    end

    it "should have approved set" do
      expect(@r.approved).to eql(false)
    end

    it "should have active set" do
      expect(@r.active).to eql(true)
    end
  end
end
