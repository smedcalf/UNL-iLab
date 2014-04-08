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
