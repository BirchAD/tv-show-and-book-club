
require 'test_helper'
require "minitest/rails/capybara"

class CreateMembershipTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
    @club = clubs(:valid_club)
  end

  test "can access new membership form" do
    login_as @user
    get new_club_membership_path(@club)
    assert_response :success
    assert_select "h1", "Add A Friend To Your Club"
    post "/clubs/:club_id/memberships", params: { membership: { user: @user, club: @club} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "Club Created"
  end
end
