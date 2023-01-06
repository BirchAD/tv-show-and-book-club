require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @club = clubs(:valid_club)
    @user = users(:valid_user)
    @second_user = users(:another_user)
  end

  test "should get index when logged in" do
    login_as @user
    get clubs_url
    assert_response :success
  end

  test "should get new club path when logged in" do
    login_as @user
    get new_club_url
    assert_response :success
  end

  test "should create club" do
    login_as @user
    assert_difference("Club.count") do
      post clubs_url, params: { club: { name: "New Club" } }
    end

    assert_redirected_to club_url(Club.last)
  end

  test "should redirect to login when not logged in" do
    get clubs_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect to root when trying to view club they are not a member of" do
    login_as @user
    get club_url(@club)
    assert_redirected_to root_path
  end

  test "should show club when logged in and a member of the club" do
    @club.memberships.create(user: @second_user)
    login_as @second_user
    get club_url(@club)
    assert_response :success
  end
end
