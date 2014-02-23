class StudentPreferencesController < ApplicationController
  def index
  end

  def new
    @projects = Project.all.map { |project| [project.name, project.id] }
    @project = Project.find(params[:id])
    @student_preference = StudentPreference.new
    @url = 'create'
  end

  def show
  end

  def create
    @student_preference = StudentPreference.new(student_preference_params)
    if @student_preference.save
      flash[:success] = "Your rating was saved"
      redirect_to preference_student_path(current_user.id)
    else
      flash[:error] = @student_preference.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    set_student_preference
    @projects = Project.all.map { |project| [project.name, project.id] }
    @project = Project.find(set_student_preference.project_id)
    @url = "update"
  end

  def update
    set_student_preference
    @url = "update"
    if @student_preference.update_attributes(student_preference_params)
      redirect_to preference_student_path(current_user.id)
    else
      redirect_to :back
    end
  end

  def delete
  end


  private

  def student_preference_params
    params.require(:student_preference).permit(:student_id, :project_id, :rating)
  end

  def set_student_preference
    @student_preference = StudentPreference.find_by_id(params[:id])
  end

end
