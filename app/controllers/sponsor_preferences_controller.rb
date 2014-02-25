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
    @student_preferences = StudentPreference.find
  end
end
