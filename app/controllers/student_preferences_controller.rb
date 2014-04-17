class StudentPreferencesController < ApplicationController

  before_action :signed_in_user
  before_action :project_open || :signed_in_instructor, only: [:new, :create, :edit, :update]

  def index
    @student_preferences = StudentPreference.where(:student_id => current_user.student.id)
  end

  def new
    @student = Student.find_by_user_id(current_user.id)
    @projects = Project.where(:semester => @student.semester).map { |project| [project.name, project.id] }
    @project = Project.find(params[:project_id])
    @student_preference = StudentPreference.new
    @url = 'create'
  end

  def show
    @student_preference = StudentPreference.find(params[:id])
  end

  def create
    @student_preference = StudentPreference.new(student_preference_params)
    if @student_preference.save
      flash[:success] = "Your rating was saved"
      redirect_to student_preference_path(:student_id => current_user.student.id, :id => @student_preference.id, :project_id => @student_preference.project_id)
    else
      flash[:error] = @student_preference.errors.full_messages.join(", ").html_safe
      redirect_to :back
    end
  end

  def edit
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
    StudentPreference.destroy(params[:student_preference])
    redirect_to :back
    flash[:success] = "Student preferences successfully deleted!"
  end

  def all
    @student_preferences = StudentPreference.all
  end


  private

  def student_preference_params
    params.require(:student_preference).permit(:student_id, :project_id, :rating, :resume, :cover_letter)
  end

  def set_student_preference
    @student_preference = StudentPreference.find_by_id(params[:id])
  end

end
