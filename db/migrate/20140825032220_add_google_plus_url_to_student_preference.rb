class AddGooglePlusUrlToStudentPreference < ActiveRecord::Migration
  def change
    add_column :student_preferences, :google_plus_url, :string
  end
end
