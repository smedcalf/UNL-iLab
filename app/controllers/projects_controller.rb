class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_project_owner || :signed_in_instructor, only: [:edit, :update]
  before_action :signed_in_instructor, only:  [:new, :create, :manage_projects]

  def index
    if current_user.utype == "instructor"
      @projects = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Project.where(:semester => it.semester).each do |p|
          @projects << p
        end
      end
    elsif current_user.utype == "sponsor"
      @projects = current_user.sponsor.projects
    else
      @projects = Project.all
    end
  end

  def new
    @project = Project.new
    @url = 'create'
    @sponsors = Sponsor.all
  end

  def create
    @project = Project.new(project_params)
    #@project.sponsor = Sponsor.find(project_params[:sponsor_id])
    if @project.valid? && @project.save
      @team = Team.new(:name => @project.name, :project => @project)
      @team.save
      flash[:success] = "New project was created and new team was created."
      redirect_to projects_path
    else
      flash[:error] = @project.errors.full_messages.join(", ").html_safe
      render 'new'
    end
  end

  def show
    set_project
  end

  def edit
    set_project
    @url = "update"
  end

  def update
    set_project
    @url = "update"
    if @project.update_attributes(project_params)
      flash[:success] = "Project was successfully saved."
      redirect_to project_path(@project.id)
    else
      flash[:error] = @project.errors.full_messages.join(", ").html_safe
      render 'edit'
    end
  end

  def manage_projects
    if params[:project].nil?
      flash[:error] = 'No project was selected!'
      redirect_to projects_path
    else
      case params[:commit]
        when 'delete'
          Project.destroy(params[:project])
          flash["success"] = "Selected Projects were deleted."
        when 'activate'
          Project.where(:id => params[:project]).update_all(:active => true)
          flash["success"] = "Selected Projects were activated."
        when 'deactivate'
          Project.where(:id => params[:project]).update_all(:active => false)
          flash["success"] = "Selected Projects were deactivated."
        when 'disable'
          Project.where(:id => params[:project]).update_all(:status => false)
          flash["success"] = "Selected Projects were disabled to apply."
        when 'enable'
          Project.where(:id => params[:project]).update_all(:status => true)
          flash["success"] = "Selected Projects were enabled to apply."
      end
      redirect_to projects_path
    end
  end

  private

    def project_params
      params.require(:project).permit(:name, :initial_capacity, :sponsor_id, :semester, :current_capacity,
                                      :proposal, :active, :status)
    end

    def set_project
      @project = Project.find_by_id(params[:id])
    end

end
