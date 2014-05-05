class SolutionsController < ApplicationController
  before_action :signed_in_instructor

  def index
    @semesters = []
    @temp = Solution.first.semester
    @semesters << @temp

    Solution.all.each do |s|
      if s.semester != @temp
        @temp = s.semester
        @semesters << @temp
      end
    end

    @solutions = Solution.all
  end

  # render name select and check button
  def names
    @semester = params[:semester]
    @names = Solution.where(:semester => @semester).select('name')

    render partial: "names", locals: { names: @names }
  end

  # Saved solution
  def saved
    @semester = params[:semester]
    @name = params[:name]
    if @name != '' && @semester != ''
      @temp = Solution.where(:semester => @semester, :name => @name).first
      @solution_id = @temp.id
      split_cvs
      render partial: "saved", locals: { solution: @solution }
    else
      flash[:error] = "Please select semester and name"
      render partial: "saved", locals: { solution: @solution, flash: flash }
    end
    flash.discard

  end

  def show
    @temp = Solution.find(params[:id])
    split_cvs
    @semester = @temp.semester
    @name = @temp.name
  end

  def auto_assign
    @temp = Solution.find(params[:id])
    split_cvs
    @solution.each do |s|
      @student = Student.where(first_name: s["first_name"], last_name: s["last_name"]).first
      @team = Team.where(name: s["project"]).first
      if @student.status == 0
        @student.update_attributes(:team => @team)
      end
    end

    flash[:success] = "Teams were successfully formed!"
    redirect_to teams_path
  end

  private

  def split_cvs
    @solution = []
    @temp.csv.split(/\r?\n/).each do |t|
      @temp_record = t.split(',')
      @record = {"first_name" => @temp_record[0], "last_name" => @temp_record[1], "project" => @temp_record[2]}
      @solution << @record
    end
  end

end
