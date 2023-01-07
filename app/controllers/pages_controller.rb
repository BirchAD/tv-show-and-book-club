class PagesController < ApplicationController
  before_action :redirect_to_club_index_if_member, only: [:home]

  def home
  end

  private

  def redirect_to_club_index_if_member
    redirect_to clubs_path if current_user&.clubs&.any?
  end
end
