class StudentPreferencesController < ApplicationController

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
    @student_preferences = StudentPreference.where(:student_id => params[:id])
  end

  def create
    @student_preference = StudentPreference.new(student_preference_params)
    if @student_preference.save
      flash[:success] = "Your rating was saved"
      redirect_to apply_student_path(current_user.student.id)
    else
      flash[:error] = @student_preference.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    set_student_preference
    @student = Student.find_by_user_id(current_user.id)
    @projects = Project.where(:semester => @student.semester).map { |project| [project.name, project.id] }
    @project = Project.find(set_student_preference.project_id)
    @url = "update"
  end

  def update
    set_student_preference
    @url = "update"
    if @student_preference.update_attributes(student_preference_params)
      flash[:success] = "Your rating was updated"
      redirect_to apply_student_path(current_user.student.id)
    else
      flash[:error] = "Your rating faild to updated"
      redirect_to :back
    end
  end

  def delete
  end

  def all
    @student_preferences = StudentPreference.all
  end


  private

  def student_preference_params
    params.require(:student_preference).permit(:student_id, :project_id, :rating)
  end

  def set_student_preference
    @student_preference = StudentPreference.find_by_id(params[:id])
  end

end
