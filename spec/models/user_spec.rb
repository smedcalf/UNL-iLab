# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  utype           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  remember_tokens :string(255)
#  email           :string(255)
#

require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "test", email: "test@example.com",
                      password: "password", password_confirmation: "password")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:password) }
  it { should respond_to(:email) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:student) }
  it { should respond_to(:student?) }
  it { should respond_to(:instructor) }
  it { should respond_to(:instructor?) }
  it { should respond_to(:sponsor) }
  it { should respond_to(:sponsor?) }
  it { should respond_to(:utype) }
  it { should respond_to(:remember_tokens) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }

    it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      @user.password = "a" * 5
      @user.password_confirmation = @user.password
    end

    it { should_not be_valid }
  end

  describe "when password and confirmation don't match" do
    before { @user.password_confirmation = "IDONTMATCH" }

    it { should_not be_valid }
  end

  describe "when password is missing" do
    before do
      @user.password = ""
      @user.password_confirmation = ""
    end

    it { should_not be_valid }
  end
end
