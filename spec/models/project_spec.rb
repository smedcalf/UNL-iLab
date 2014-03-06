# == Schema Information
#
# Table name: projects
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  initial_capacity      :integer
#  sponsor_id            :integer
#  sponsor_type          :string(255)
#  current_capacity      :integer
#  semester              :string(255)
#  proposal_file_name    :string(255)
#  proposal_content_type :string(255)
#  proposal_file_size    :integer
#  active                :boolean
#  status                :boolean
#  created_at            :datetime
#  updated_at            :datetime
#
# Indexes
#
#  index_projects_on_sponsor_id_and_sponsor_type  (sponsor_id,sponsor_type)
#

require 'spec_helper'

describe Project do

end
