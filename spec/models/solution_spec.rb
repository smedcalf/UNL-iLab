# == Schema Information
#
# Table name: solutions
#
#  id         :integer          not null, primary key
#  semester   :string(255)
#  name       :string(255)
#  csv        :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Solution do

  before do
    @solution = Solution.new()
  end

  it { should respond_to(:semester) }
  it { should respond_to(:name) }
  it { should respond_to(:csv) }

  it { should be_valid }
end
