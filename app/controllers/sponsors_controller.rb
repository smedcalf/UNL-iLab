class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
  end

  def show
  end

  def edit
  end
end
