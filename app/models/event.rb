class Event < ActiveRecord::Base
  has_event_calendar
  validates :name, :description, :user_id, :start_at, :end_at, presence: true
  scope :completed, :conditions=>['completed = true']
  scope :incomplete, :conditions=>['completed = false']

end
