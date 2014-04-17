class SolutionsController < ApplicationController

  def index
    @solution = Solution.first
    @solution_records = @solution.csv.split(/\r?\n/)
  end

end
