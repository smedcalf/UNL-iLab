class StudentPreferencesController < ApplicationController

  before_action :signed_in_user
  before_action :project_open || :signed_in_instructor, only: [:new, :create, :edit, :update]
  before_action :signed_in_instructor, only: [:list_preferences_for_student]


  def index
    @student_preferences = StudentPreference.where(:student_id => current_user.student.id)
  end

  def list_preferences_for_student
    @student_preferences = StudentPreference.where(:student_id => params[:student_id])
    @student = Student.find params[:student_id]
    @projects = Project.where(:semester => @student.semester, :status => true)

    # Get projects the student hasn't already applied to so that instructors can
    # sign the student up for them if needed
    @unapplied_projects = []
    for project in @projects
      if @student.student_preferences.none? {|pref| pref.project.id == project.id}
        @unapplied_projects.push project
      end
    end
  end

  def new
    rating_options
    if current_user.instructor?
      @student = Student.find_by_id(params[:student_id])
    else
      @student = Student.find_by_user_id(current_user.id)
    end

    @projects = Project.where(:semester => @student.semester, :status => true).map { |project| [project.name, project.id] }
    @project = Project.find(params[:project_id])
    @student_preference = StudentPreference.new

    if current_user.instructor?
      @student_preference.student = @student
    end

    @url = 'create'
  end

  def show
    @student_preference = StudentPreference.find(params[:id])
  end

  def create
    @student_preference = StudentPreference.new(student_preference_params)
    if !StudentPreference.where(:student_id => @student_preference.student_id, :project_id => @student_preference.project_id).any?
      if @student_preference.save
        flash[:success] = "Your rating was saved"
        if current_user.instructor?
          redirect_to student_preference_path(:student_id => @student_preference.student.id, :id => @student_preference.id, :project_id => @student_preference.project_id)
        else
          redirect_to student_preference_path(:student_id => current_user.student.id, :id => @student_preference.id, :project_id => @student_preference.project_id)
        end
      else
        flash[:error] = @student_preference.errors.full_messages.join(", ").html_safe
        redirect_to :back
      end
    else
      flash[:error] = "You have rated this project"
      redirect_to :back
    end
  end

  def edit
    rating_options
    set_student_preference
    @student = Student.find(params[:student_id])
    @projects = Project.where(:semester => @student.semester).map { |project| [project.name, project.id] }
    @project = Project.find(set_student_preference.project_id)
    @url = "update"
  end

  def update
    set_student_preference
    @url = "update"
    if @student_preference.update_attributes(student_preference_params)
      flash[:success] = "Your rating was updated"
      redirect_to student_preference_path(:student_id => @student_preference.student_id, :id => @student_preference.id)
    else
      flash[:error] = @student_preference.errors.full_messages.join(", ").html_safe
      redirect_to :back
    end
  end

  def destroy
    if params[:student_preference]
      StudentPreference.destroy(params[:student_preference])
      flash[:success] = "Student preferences successfully deleted!"
    else
      flash[:error] = "Please select ratings you want to delete."
    end
    redirect_to :back
  end

  def all
    @student_preferences = StudentPreference.all
  end


  private

  def student_preference_params
    params.require(:student_preference).permit(:student_id, :project_id, :rating, :resume, :cover_letter, :github_url, :google_plus_url)
  end

  def set_student_preference
    @student_preference = StudentPreference.find_by_id(params[:id])
  end

  def rating_options
    if current_user.student?
      #if Student.where(:semester => current_user.student.semester).count > 10
        @rating_options = [{"value" => "", "label" => "Please select..."},
                           {"value" => "0", "label" => "Low Priority"},
                           {"value" => "1", "label" => "Below Average Priority"},
                           {"value" => "2", "label" => "Average Priority"},
                           {"value" => "3", "label" => "Above Average Priority"},
                           {"value" => "4", "label" => "High Priority"},
                           {"value" => "5", "label" => "Highest Priority"}]

    else
      @rating_options = [{"value" => "", "label" => "Please select..."},
                         {"value" => "0", "label" => "Low Priority"},
                         {"value" => "1", "label" => "Below Average Priority"},
                         {"value" => "2", "label" => "Average Priority"},
                         {"value" => "3", "label" => "Above Average Priority"},
                         {"value" => "4", "label" => "High Priority"},
                         {"value" => "5", "label" => "Highest Priority"}]
    end

  end
end
