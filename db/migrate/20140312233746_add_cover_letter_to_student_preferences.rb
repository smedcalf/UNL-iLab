class AddCoverLetterToStudentPreferences < ActiveRecord::Migration
  def change
    add_column :student_preferences, :cover_letter_content_type, :string
    add_column :student_preferences, :cover_letter_file_name, :string
    add_column :student_preferences, :cover_letter_file_size, :integer
    add_column :student_preferences, :resume_content_type, :string
    add_column :student_preferences, :resume_file_name, :string
    add_column :student_preferences, :resume_file_size, :integer
  end
end
