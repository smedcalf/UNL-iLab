class TeamsController < ApplicationController
  before_action :signed_in_user
  
  def new
    @team = Team.new
    @projects = Project.all
  end

  def create
    @url = "create"
    @team = Team.new(team_params)
    if team_params[:project_id]
      @team.project = Project.find(team_params[:project_id])
      if @team.save
        redirect_to teams_path
      else
        render 'new'
      end
    else
      flash[:error] = 'Please select project to make a team'
      redirect_to :back
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
    if params[:team].nil?
      flash[:error] = 'No team was selected'
      redirect_to students_path
    elsif params[:student].nil?
           flash[:error] = "No student was selected"
           redirect_to students_path
    else
        team = Team.find_by_id(params[:team])
        Student.where(:id => params[:student]).update_all(:status => true)
        team.students << Student.find(params[:student])
        team.save
        flash[:success] = "Student has been successfully assigned."
        redirect_to students_path
    end
  end

  def delete_teams
    Team.destroy(params[:team])
    redirect_to teams_path
  end

  private

    def team_params
      params.require(:team).permit(:name, :project_id, :google_drive, :trello_link)
    end

    def set_team
      @team = Team.find_by_id(params[:id])
    end
end
