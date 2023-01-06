class MembershipsController < ApplicationController
  before_action :set_club, only: %i[new create]

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new
    @membership.user = User.find_by(email: membership_params[:user])
    @membership.club = @club
    if @membership.save!
      redirect_to club_path(@club), notice: "#{@membership.user.username} was added to the club"
    else
      render :new, status: :unprocessable_entity, notice: 'The user was not added to the club.'
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def membership_params
    params.require(:membership).permit(:user)
  end
end
