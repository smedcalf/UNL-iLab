class ChangeColumnsTypeToSolution < ActiveRecord::Migration
  def change
    change_column :solutions, :project_data, :binary, :limit => 16.megabyte
    change_column :solutions, :student_data, :binary, :limit => 16.megabyte
  end
end
