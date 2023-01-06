require 'test_helper'

class ClubMembershipAuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @club = clubs(:valid_club)
    @member = users(:second_user)
    @non_member = users(:another_user)
  end

  test "members can view club" do
    login_as @member
    get club_path(@club)
    assert_response :success
  end

  test "non-members cannot view club" do
    login_as @non_member
    get club_path(@club)
    assert_redirected_to root_path
    follow_redirect!
    assert_select "div.alert", text: 'You are not a member of this club.'
  end
end
