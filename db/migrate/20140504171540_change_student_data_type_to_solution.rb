class ChangeStudentDataTypeToSolution < ActiveRecord::Migration
  def change
    change_column :solutions, :student_data, :binary, :limit => 16.megabyte
  end
end
