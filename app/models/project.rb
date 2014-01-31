class Project < ActiveRecord::Base
  belongs_to :sponsor, polymorphic: true
  has_one :team
  validates :project_name, :initial_capacity, :semester, :sponsor,  :presence => true
  validates :project_name, :uniqueness => true

  after_initialize :set_defaults

  has_attached_file :proposal


  private
  def set_defaults
    if self.new_record?
      self.initial_capacity = 4
      self.current_capacity = self.initial_capacity
      self.active = 0
      self.status = 0
    end
  end


end
