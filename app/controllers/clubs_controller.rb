class ClubsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_club_access, except: [:create, :new]

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
    @members = @club.memberships
  end

  private

  def club_params
    params.require(:club).permit(:name)
  end

  def authorize_club_access
    # Verify that the user has a membership to the club
    club = Club.find(params[:id])
    redirect_to root_path, alert: 'You are not a member of this club.' unless current_user.clubs.include?(club)
  end
end
