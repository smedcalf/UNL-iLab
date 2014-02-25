class SponsorPreferencesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def application
    @projects = Project.where(:sponsor_id => params[:id])
    @url = "preference"
  end

  def preference
    @student_preferences = StudentPreference.where(:project_id => params[:id])
    render partial: "preference", locals: { student_preferences: @student_preferences }
  end

  def update
    hkj
    render text: params.to_s
  end
end
