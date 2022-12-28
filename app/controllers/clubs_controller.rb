class ClubsController < ApplicationController
  before_action :authenticate_user!

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    @club.user = current_user
    if @club.save!
      redirect_to club_path(@club), notice: 'Your club was successfully created.'
    else
      render 'new'
    end
  end

  def show
    @club = Club.find(params[:id])
  end

  private

  def club_params
    params.require(:club).permit(:name)
  end
end
