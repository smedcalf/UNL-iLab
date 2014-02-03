class TeamsController < ApplicationController
  def new
    @team = Team.new
    @projects = Project.all
  end

  def create
    @url = "create"
    @team = Team.new(team_params)
    @team.project = Project.find(team_params[:project_id])
    if @team.save
      redirect_to teams_path
    else
      render 'new'
    end
  end

  def show
    set_team
  end

  def edit
    set_team
    @url = "update"
  end

  def index
    @teams = Team.all
  end

  def update
    set_team
    @url = "update"
    if @team.update_attributes(team_params)
      redirect_to team_path(@team.id)
    else
      render 'edit'
    end
  end

  def add_students
    team = Team.find_by_id(params[:team])
    team.students << Student.find(params[:student])
    team.save
    redirect_to students_path
  end

  def delete_teams
    Team.destroy(params[:team])
    redirect_to teams_path
  end

  private

    def team_params
      params.require(:team).permit(:name, :project_id)
    end

    def set_team
      @team = Team.find_by_id(params[:id])
    end
end
