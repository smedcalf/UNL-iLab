class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    if @sponsor.save
      redirect_to sponsors_path, :notice => 'New sponsor has been created successfully.'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  private
  def sponsor_params
    params.require(:sponsor).permit(:email, :first_name, :last_name, :orgnization, :type)
  end
end
