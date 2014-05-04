class AddColumnsToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :student_data, :binary, :limit => 10.megabyte
    add_column :solutions, :project_data, :binary, :limit => 10.megabyte
    change_column :solutions, :csv, :text, :limit => 4294967295
  end
end
