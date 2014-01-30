class Project < ActiveRecord::Base
  belongs_to :sponsors, polymorphic: true
  has_one :team
end
