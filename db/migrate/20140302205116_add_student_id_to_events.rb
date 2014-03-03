class AddStudentIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :student_id, :integer
  end
end
