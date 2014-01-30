class AddStudentsToTeams < ActiveRecord::Migration
  def change
  	change_table :students do |t|
  		t.belongs_to :team
  	end
  end
end
