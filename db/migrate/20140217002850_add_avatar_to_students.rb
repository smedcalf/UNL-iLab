class AddAvatarToStudents < ActiveRecord::Migration
  def up
  	add_attachment :students, :avatar
  end

  def down
  	remove_attachment :students, :avatar
  end
end
