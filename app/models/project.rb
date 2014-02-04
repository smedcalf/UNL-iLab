class Project < ActiveRecord::Base
  belongs_to :sponsor, polymorphic: true
  has_many :team, :dependent => :destroy
  validates :name, :initial_capacity, :semester, :sponsor,  :presence => true
  validates :name, :uniqueness => true

  after_initialize :set_defaults

  has_attached_file :proposal


  private
  def set_defaults
    if self.new_record?
      self.initial_capacity = 4 if self.initial_capacity.blank?
      self.current_capacity = self.initial_capacity
      self.active = 0 if self.active.blank?
      self.status = 0 if self.status.blank?
    end
  end


end
