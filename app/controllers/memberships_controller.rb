class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
    @club = Club.find(params[:club_id])
  end
end
