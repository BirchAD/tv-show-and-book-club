class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:show]

  def show
    @user = current_user
  end

  private

  def authorize_user
    return unless current_user == @user

    flash[:alert] = "Your can only view your profile"
    redirect_to profile_path
  end
end
