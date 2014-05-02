class SponsorsController < ApplicationController
  before_action :signed_in_user

  def index
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
    if !current_user.instructor?
      @sponsor.email = current_user.email
    end
    @url = "create"
  end

  def create
    @pwd = SecureRandom.hex(4)
    @user = User.new(:name => params[:sponsor][:email].partition("@").first, :email => params[:sponsor][:email],
                     :password => @pwd, :password_confirmation => @pwd, :utype => "sponsor")
    @sponsor = Sponsor.new(sponsor_params)
    if @user.valid?
      if @sponsor.valid?
        @user.save
        if current_user.sponsor?
          @sponsor.user_id = current_user.id
        else
          @sponsor.user_id = @user.id
        end
        @sponsor.save
        flash[:success] = "New sponsor has been created successfully. Username: #{@user.name}, Password: #{@pwd}"
        redirect_to sponsors_path
      else
        flash[:error] = @sponsor.errors.full_messages.join(", ").html_safe
        render 'new'
      end
    else
      flash.now[:error] = @user.errors.full_messages.join(", ").html_safe
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
