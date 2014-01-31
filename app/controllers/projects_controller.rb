class ProjectsController < ApplicationController
  def index

  end

  def new
    @project = Project.new
    @url = 'create'
    @sponsors = Sponsor.all
  end

  def create
    @project = Project.new(project_params)
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
    params.require(:project).permit(:project_name, :initial_capacity, :sponsor_id, :sponsor_type, :semester, :current_capacity,
                                    :proposal, :active, :status)
  end
end