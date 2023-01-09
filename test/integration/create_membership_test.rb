require 'test_helper'
require "minitest/rails/capybara"

class CreateMembershipTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:another_user)
    @club = clubs(:valid_club)
    @new_user = users(:another_user)
  end

  test "can access new membership form" do
    login_as @user
    get new_club_membership_path(@club)
    assert_response :success
    assert_select "h1", "Add A Friend To Your Club"
    post "/clubs/#{@club.id}/memberships", params: { club_id: @club.id, membership: { user: @new_user.email } }
    assert_redirected_to club_path(@club)
    follow_redirect!
    assert_response :success
  end

  test "creates a new membership" do
    login_as @user
    assert_difference "Membership.count", 1 do
      post "/clubs/#{@club.id}/memberships", params: { club_id: @club.id, membership: { user: @user.email } }
    end
    must_redirect_to club_path(@club)
  end

  test "does not create a duplicate membership" do
    Membership.create(user_id: @new_user.id, club_id: @club.id)
    login_as @user
    assert_no_difference "Membership.count" do
      post "/clubs/#{@club.id}/memberships", params: { club_id: @club.id, membership: { user: @new_user.email } }
    end
  end

  test "displays the correct error message" do
    Membership.create(user_id: @new_user.id, club_id: @club.id)
    @membership = Membership.new(user_id: @new_user.id, club_id: @club.id)
    @membership.save
    assert_includes @membership.errors.full_messages, "User is already a member of this club"
  end
end
