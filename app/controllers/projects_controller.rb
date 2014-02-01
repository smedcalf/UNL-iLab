class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @url = 'create'
    @sponsors = Sponsor.all
  end

  def create
    @project = Project.new(project_params)
    @project.sponsor = Sponsor.find(project_params[:sponsor_id])
    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  private
  def project_params
    params.require(:project).permit(:project_name, :initial_capacity, :sponsor_id, :semester, :current_capacity,
                                    :proposal, :active, :status)
  end
end