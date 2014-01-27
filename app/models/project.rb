class Project < ActiveRecord::Base
  belongs_to :sponsors, polymorphic: true
end
