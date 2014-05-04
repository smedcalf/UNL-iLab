# == Schema Information
#
# Table name: solutions
#
#  id           :integer          not null, primary key
#  semester     :string(255)      not null
#  name         :string(255)      not null
#  csv          :text(2147483647) not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  student_data :binary(214748364
#  project_data :binary(214748364
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
