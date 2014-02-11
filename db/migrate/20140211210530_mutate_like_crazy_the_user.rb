class MutateLikeCrazyTheUser < ActiveRecord::Migration
  def change
  	change_table :students do |t|
  		t.belongs_to :user
  	end

  	change_table :instructors do |t|
  		t.belongs_to :user
  	end

  	change_table :sponsors do |t|
  		t.belongs_to :user
  	end
  end
end
