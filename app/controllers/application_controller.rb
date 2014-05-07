class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

	def not_found
  	raise ActionController::RoutingError.new('Not Found')
  end

  def set_active_projects
    if current_user.utype == "instructor"
      @projects = []
      @instructor_terms = InstructorTerm.where(:instructor_id => current_user.instructor.id)
      @instructor_terms.each do |it|
        Project.where(:semester => it.semester, :active => true).each do |p|
          @projects << p
        end
      end
    elsif current_user.utype == "sponsor"
      @projects = current_user.sponsor.projects.where(:active => true)
    else
      @projects = Project.where(:active => true)
    end
  end

end
