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

class Sponsor < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
