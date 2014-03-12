class TeamsController < ApplicationController
  before_action :signed_in_user
  before_action :signed_in_instructor, except: [:index, :show, :work_track]
  
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
    if current_user.sponsor.nil?
      @teams = Team.all
    else
      @projects = Project.where(:sponsor_id => current_user.sponsor.id)
      @teams = Team.where(:project_id => @projects.ids)
    end
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

  def work_track
    #@tasks = Event.where{(team_id == params[:id]) | (user_id == current_user.id)}
    @tasks = Event.where("team_id = #{params[:id]}")
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
