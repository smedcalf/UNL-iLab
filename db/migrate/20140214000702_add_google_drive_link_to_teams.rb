class AddGoogleDriveLinkToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :google_drive, :string
  end
end
