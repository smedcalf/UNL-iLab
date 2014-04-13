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

class Request < ActiveRecord::Base

  belongs_to :student, dependent: :destroy

  validates :start_date, :end_date, :presence => true
  validates :student_id, :uniqueness => true

  after_initialize :set_defaults


  private

    def set_defaults
      if self.new_record?
        self.active = true
        self.approved = false
      end
    end

end
