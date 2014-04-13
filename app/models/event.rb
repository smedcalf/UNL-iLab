# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  start_at    :datetime
#  end_at      :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  team_id     :integer
#  url         :string(255)
#  priority    :integer
#  description :text
#  completed   :boolean          default(FALSE), not null
#  user_id     :integer
#

class Event < ActiveRecord::Base
  has_event_calendar

  belongs_to :user, dependent: :destroy

  validates :name, :description, :user_id, :start_at, :end_at, presence: true
  scope :completed, :conditions=>['completed = true']
  scope :incomplete, :conditions=>['completed = false']

end
