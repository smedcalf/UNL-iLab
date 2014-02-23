class PreferencesController < ApplicationController
  before_action :signed_in_user

  def new
    @project = Project.find(params[:id])
    @student_preference = StudentPreference.new
    @url = 'create'
  end

  def create
    @student_preference = StudentPreference.new(student_preference_params)
  end

  def student_preferences
    @student_preferences = StudentPreference.all
  end

  def sponsor_preferences
    @sponsor_preferences = SponsorPreference.all
  end

  def update_sponsor_preference

  end

  private

  def student_preference_params
    params.require(:student).permit(:student_id, :project_id, :rating)
  end

  def set_student_preference
    @student_preference = StudentPreference.find_by_id(params[:id])
  end
end
