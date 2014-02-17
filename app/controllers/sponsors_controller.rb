class SponsorsController < ApplicationController
  before_action :signed_in_user
  
  def index
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
    @url = "create"
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    if current_user.utype == "sponsor"
      @sponsor.user_id = current_user.id
    end
    if @sponsor.save
      redirect_to sponsors_path, :notice => 'New sponsor has been created successfully.'
    else
      render 'new'
    end
  end

  def show
    set_sponsor
    @projects = Project.where(:sponsor_id => params[:id])
  end

  def edit
    set_sponsor
    @url = "update"
  end

  def update
    set_sponsor
    @url = "update"
    if @sponsor.update_attributes(sponsor_params)
      redirect_to sponsor_path(@sponsor.id)
    else
      render 'edit'
    end
  end

  def preference
    @projects = Project.where(:sponsor_id => User.find(params[:id]).sponsor)
    @student_preferences = StudentPreference.where(:project_id => @projects.ids)

  end

  def update_preference

  end

  private

    def sponsor_params
      params.require(:sponsor).permit(:email, :first_name, :last_name, :organization, :type)
    end

    def set_sponsor
      @sponsor = Sponsor.find_by_id(params[:id])
    end
end
