class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsors.all
  end

  def new
    @sponsor = Sponsors.new
  end

  def show
  end

  def edit
  end
end
