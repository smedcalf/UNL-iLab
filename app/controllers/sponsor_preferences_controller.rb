class SponsorPreferencesController < ApplicationController
  before_action :can_view_preferences

  def index
    if current_user.instructor?
      @sponsor = current_user.instructor
      @projects = Project.all
    else
      @sponsor = current_user.sponsor
      @projects = Project.where(sponsor_id: params[:sponsor_id])
    end

  end

  def new
  end

  def application
    @projects = Project.where(:sponsor_id => params[:sponsor_id])
    @url = "preference"
  end

  def student
    if params[:id]
      @project_id = params[:id]
      rating_options
      if current_user.instructor?
        @sponsor = current_user.instructor
      else
        @sponsor = current_user.sponsor
      end

      @student_preferences = StudentPreference.where(:project_id => params[:id])
      render partial: "student", locals: { student_preferences: @student_preferences, project_id: @project_id }
    else
      flash[:error] = "Please select a project."
      @student_preferences = false
      render partial: "student", locals: { student_preferences: @student_preferences, flash: flash }
    end
    flash.discard
  end

  def update_preferences
    params[:rating].each do |key, value|
      @student_preference = StudentPreference.find(key.to_i)
      student_id = @student_preference.student_id
      project_id = @student_preference.project_id
      rating = value.first.to_i
      @sponsor_preference = SponsorPreference.where(:project_id => project_id, :student_id => student_id)
      if(@sponsor_preference.any?)
        @sponsor_preference.first.rating = rating
        @sponsor_preference.first.save
      else
        @sponsor_preference = SponsorPreference.new
        @sponsor_preference.student_id = student_id
        @sponsor_preference.project_id = project_id
        @sponsor_preference.rating = rating
        @sponsor_preference.save
      end
    end

    if current_user.instructor?
      @sponsor = current_user.instructor
    else
      @sponsor = current_user.sponsor
    end
    @project_id = params[:project_id]
    rating_options
    @student_preferences = StudentPreference.where(project_id: @project_id)
    flash[:success] = "Your rating was successfully saved!"
    render partial: "student", locals: { student_preferences: @student_preferences, flash: flash, project_id: @project_id }
    flash.discard
  end

  def all
    @teams = Team.all
    @sponsor_preferences = SponsorPreference.all
  end

  private

    def sponsor_preference_params
      params.require(:sponsor_preference).permit(:student_id, :project_id, :rating)
    end

    def sponsor_student_preference
      @sponsor_preference = SponsorPreference.find_by_id(params[:id])
    end

    def rating_options
      if !@project_id.nil?
        @project = Project.find(@project_id)
      else
        @project = Project.find(params[:id])
      end
      if Student.where(:semester => @project.semester).count > 10
        @rating_options = [{"value" => "", "label" => "Please select..."},
                           {"value" => "0", "label" => "0 Absolutely Disagree"},
                           {"value" => "1", "label" => "1 Strongly Disagree"},
                           {"value" => "2", "label" => "2 Disagree"},
                           {"value" => "3", "label" => "3 Neither Agree nor Disagree"},
                           {"value" => "4", "label" => "4 Agree"},
                           {"value" => "5", "label" => "5 Strongly Agree"}]
      else
        @rating_options = [{"value" => "", "label" => "Please select..."},
                           {"value" => "0", "label" => "0 Absolutely Disagree"},
                           {"value" => "1", "label" => "1 Disagree"},
                           {"value" => "2", "label" => "2 Agree"},
                           {"value" => "3", "label" => "3 Strongly Agree"}]
      end
    end

    def can_view_preferences
      sponsor? || instructor?
    end
end
