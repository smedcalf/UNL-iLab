class AddGithubUrlToStudentPreference < ActiveRecord::Migration
  def change
    add_column :student_preferences, :github_url, :string
  end
end
