class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_filter :session_expires, :except => [:new, :create, :destroy]
  before_filter :update_session_time, :except => [:create, :destroy]

  def session_expires
    @time_left = (session[:expires_at].to_i - Time.now.to_i).to_i
    unless @time_left > 0
      sign_out
      reset_session
      flash[:error] = 'Session expired'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  def update_session_time
    session[:expires_at] = 10.minutes.from_now
  end

	def not_found
  	raise ActionController::RoutingError.new('Not Found')
  end

  def set_approved_projects
    if current_user.utype == "instructor"
      @projects = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Project.where(:semester => it.semester, :active => true, :status => true).each do |p|
          @projects << p
        end
      end
    elsif current_user.utype == "sponsor"
      @projects = current_user.sponsor.projects.where(:active => true, :status => true)
    else
      @projects = Project.where(:active => true, :status => true)
    end
  end

  def set_active_projects
    if current_user.utype == "instructor"
      @projects = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Project.where(:semester => it.semester, :active => true, :status => false).each do |p|
          @projects << p
        end
      end
    elsif current_user.utype == "sponsor"
      @projects = current_user.sponsor.projects.where(:active => true, :status => false)
    else
      @projects = Project.where(:active => true, :status => false)
    end
  end

end
