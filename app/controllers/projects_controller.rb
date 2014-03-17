class ProjectsController < ApplicationController
  before_action :signed_in_user

  def index
    if current_user.sponsor.nil?
      @projects = Project.all
    else
      @projects = current_user.sponsor.projects
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
    if @project.save
      flash[:success] = "New project was created."
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
        when 'activate'
          Project.where(:id => params[:project]).update_all(:active => true)
        when 'enable'
          Project.where(:id => params[:project]).update_all(:status => true)
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
