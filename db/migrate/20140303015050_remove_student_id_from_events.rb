class RemoveStudentIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :student_id, :integer
  end
end
