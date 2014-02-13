class PreferencesController < ApplicationController
  before_action :signed_in_user

  def student_preferences
    @student_preferences = StudentPreference.all
  end

  def sponsor_preferences
  end
end
