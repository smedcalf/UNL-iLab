class InstructorTermsController < ApplicationController
  def index
    @instructors = Instructor.all
    semester_options
  end

  def show
    set_instructor_term
  end

  def new
    @instructor_term = InstructorTerm.new
  end

  def addSemester
    if params[:instructor].nil?
      flash[:error] = "No instructor was selected."
      redirect_to instructor_terms_path
    else
      case params[:commit]
        when 'unassign'
          InstructorTerm.where(:instructor_id => params[:instructor], :semester => params[:semester]).destroy_all
          flash[:success] = "Semester has been unassigned from the instructors."
        when 'add'
          params[:instructor].each do |i|
            if !check_exist(i, params[:semester])
              InstructorTerm.create(:instructor_id => i, :semester => params[:semester])
            end
          end
          flash[:success] = "Semester has been added to the instructors."
      end
      #UserMailer.user_type_confirmation(@user.first).deliver
      redirect_to instructor_terms_path
    end
  end


  private

    def instructor_term_params
      params.require(:instructor_term).permit(:semester, :instructor)
    end

    def set_instructor_term
      @instructor_term = InstructorTerm.find_by_instructor_id(params[:id])
    end

  def check_exist(instructor_id, semester)
    if InstructorTerm.where(:instructor_id => instructor_id, :semester => semester).any?
      return true
    end
  end

  def semester_options
    if Time.now.month >= 8
      @current_year = Time.now.year
      @last_year = Time.now.year + 1
    else
      @current_year = Time.now.year
      @last_year = Time.now.year - 1
    end
    @semester_options = [{"value" => "Fall #{@last_year}", "label" => "Fall #{@last_year}"},
                         {"value" => "Spring #{@last_year}", "label" => "Spring #{@last_year}"},
                         {"value" => "Fall #{@current_year}", "label" => "Fall #{@current_year}"},
                         {"value" => "Spring #{@current_year}", "label" => "Spring #{@current_year}"}]
  end
end
