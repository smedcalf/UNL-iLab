class AddTrelloLinkToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :trello_link, :string
  end
end
