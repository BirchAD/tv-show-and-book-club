require 'test_helper'

class ClubMembershipAuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @club = clubs(:valid_club)
    @member = users(:second_user)
    @non_member = users(:another_user)
  end

  test "members can view club" do
    # Log in as a club member
    login_as(@member)

    # Visit the club's page
    get club_path(@club)

    # Verify that the user can view the club's page
    assert_response :success
  end

  test "non-members cannot view club" do
    # Log in as a non-member
    login_as(@non_member)

    # Visit the club's page
    get club_path(@club)

    # Verify that the user is redirected to the root path
    assert_redirected_to root_path

    # Follow the redirect
    follow_redirect!

    # Verify that the user sees an error message
    assert_select "div.alert", text: 'You are not a member of this club.'
  end
end
