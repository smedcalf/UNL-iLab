# == Schema Information
#
# Table name: sponsors
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  organization :string(255)
#  email        :string(255)
#  type         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#
# Indexes
#
#  index_sponsors_on_email  (email) UNIQUE
#

require 'spec_helper'

describe Sponsor do

  before do
    @sponsor = Sponsor.new(first_name: "Test", last_name: "Sponsor",
                           email: "sponsor@test.com")
  end

  subject { @sponsor }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:organization) }
  it { should respond_to(:email) }
  it { should respond_to(:type) }
  it { should respond_to(:user) }
  it { should respond_to(:projects) }

  it { should be_valid }

  describe "full name" do

    it "should have a full name" do
      expect(@sponsor.full_name).to eql("Test Sponsor")
    end
  end
end
