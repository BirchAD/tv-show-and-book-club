class ClubsController < ApplicationController
  before_action :authenticate_user!

  def new
    @club = Club.new
  end
end
