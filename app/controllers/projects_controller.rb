class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :signed_in_instructor, only:  [:edit, :update, :new, :create, :manage_projects, :pending, :edit_instructors, :update_instructors]

  def index
    approve_project_manage_options

    # set active projects defined in application_controller
    set_approved_projects
  end

  def active
    project_manage_options

    # set active projects defined in application_controller
    set_active_projects
  end

  def past
    past_project_manage_options
    if current_user.utype == "instructor"
      @projects = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Project.where(:semester => it.semester, :active => false, :status => false).each do |p|
          @projects << p
        end
      end
    elsif current_user.utype == "sponsor"
      @projects = current_user.sponsor.projects
    else
      @projects = Project.where(:active => false, :status => false)
    end
  end

  def pending
    pending_project_manage_options
    if current_user.utype == "instructor"
      @projects = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Project.where(:semester => it.semester, :active => false, :status => true).each do |p|
          @projects << p
        end
      end
    elsif current_user.utype == "sponsor"
      @projects = current_user.sponsor.projects
    else
      @projects = Project.where(:active => false, :status => true)
    end
  end

  def new
    @project = Project.new
    @url = 'create'
    @sponsors = Sponsor.all
  end

  def create
    @project = Project.new(project_params)
    @project.sponsor = Sponsor.find(project_params[:sponsor_id])
    if @project.valid? && @project.save
      @team = Team.new(:name => @project.name, :project => @project)
      @team.save
      if @project.active?
        flash[:success] = "New project was created and new team was created. And team called #{@team.name} was automatically created, please check teams table."
        redirect_to projects_path
      else
        flash[:success] = "New project was created and new team was created. And team called #{@team.name} was automatically created, please check teams table."
        redirect_to pending_projects_path
      end

    else
      flash[:error] = @project.errors.full_messages.join(", ").html_safe
      render 'new'
    end
  end

  def show
    set_project
  end

  def delete
    @project = Project.find_by_id(params[:id])
    Project.destroy(@project)
    flash[:success] = "Selected Projects were deleted."
    redirect_to(:back)
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
      redirect_to(:back)
    else
      case params[:option]
        when 'archive'
          Project.where(:id => params[:project]).update_all(:active => false, :status => false)
          flash[:success] = "Selected Projects were archived. Please check your past projects"
          redirect_to past_projects_path and return
        when 'activate'
          Project.where(:id => params[:project]).update_all(:active => true, :status => false)
          flash[:success] = "Selected Projects were activated."
          redirect_to active_projects_path and return
        when 'pending'
          Project.where(:id => params[:project]).update_all(:active => false, :status => true)
          flash[:success] = "Selected Projects are now pending approval."
          redirect_to pending_projects_path and return
        when 'approve'
          Project.where(:id => params[:project]).update_all(:active =>true, :status => true)
          flash[:success] = "Selected Projects were approved to apply."
          redirect_to projects_path and return
        else
          case params[:commit]
            when 'delete'
              Project.destroy(params[:project])
              flash[:success] = "Selected Projects were deleted."
            when 'archive'
              Project.where(:id => params[:project]).update_all(:active => false, :status => false)
              flash[:success] = "Selected Projects were archived. Please check your past projects"
              redirect_to past_projects_path and return
            when 'activate'
              Project.where(:id => params[:project]).update_all(:active => true, :status => false)
              flash[:success] = "Selected Projects were activated."
              redirect_to active_projects_path and return
            when 'approve'
              Project.where(:id => params[:project]).update_all(:active =>true, :status => true)
              flash[:success] = "Selected Projects were approved for application."
              redirect_to projects_path and return
            when 'pending'
              Project.where(:id => params[:project]).update_all(:active => false, :status => true)
              flash[:success] = "Selected Projects are now pending approval."
              redirect_to pending_projects_path and return
          end
      end
      redirect_to(:back)
    end
  end

  def edit_instructors
    set_project
    @instructors = Instructor.all
  end

  def update_instructors
    set_project
    if current_user.utype == "admin" || current_user.utype == "instructor"
      for instructor in Instructor.all
        if params["instructor_#{instructor.id}"]
          if !(@project.instructors.include? instructor)
            @project.instructors.push instructor
          end
        else
          @project.instructors.delete instructor
        end
      end

      if @project.save
        flash[:success] = "Instructor assignments were successfully saved."
        @url = "update"
        redirect_to edit_project_path(@project.id)
      else
        flash[:error] = "There was a problem saving your changes."
        @instructors = Instructor.all
        render 'edit_projects'
      end
    else
      flash[:error] = "Access denied"
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

    def project_manage_options
      if current_user.utype == "admin" || current_user.utype == "instructor"
        @project_manage_options = [{"value" => "", "label" => "Please select..."},
                                  {"value" => "approve", "label" => "Approve"},
                                  {"value" => "pending", "label" => "Pending"},
                                  {"value" => "archive", "label" => "Archive"}]
      else
        @project_manage_options = [{"value" => "", "label" => "You don't have authority to manage project"}]
      end
    end

    def past_project_manage_options
      if current_user.utype == "admin" || current_user.utype == "instructor"
        @past_project_manage_options = [{"value" => "", "label" => "Please select..."},
                                  {"value" => "activate", "label" => "Activate"},
                                  {"value" => "approve", "label" => "Approve"},
                                  {"value" => "pending", "label" => "Pending"}]
      else
        @past_project_manage_options = [{"value" => "", "label" => "You don't have authority to manage project"}]
      end
    end

    def pending_project_manage_options
      if current_user.utype == "admin" || current_user.utype == "instructor"
        @pending_project_manage_options = [{"value" => "", "label" => "Please select..."},
                                        {"value" => "activate", "label" => "Activate"},
                                        {"value" => "approve", "label" => "Approve"},
                                        {"value" => "archive", "label" => "Archive"}]
      else
        @pending_project_manage_options = [{"value" => "", "label" => "You don't have authority to manage project"}]
      end
    end

    def approve_project_manage_options
      if current_user.utype == "admin" || current_user.utype == "instructor"
        @approve_project_manage_options = [{"value" => "", "label" => "Please select..."},
                                        {"value" => "activate", "label" => "Activate"},
                                        {"value" => "pending", "label" => "Pending"},
                                        {"value" => "archive", "label" => "Archive"}]
      else
        @approve_project_manage_options = [{"value" => "", "label" => "You don't have authority to manage project"}]
      end
    end

end
