require 'test_helper'

class UserCreateClubTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:valid_user)
    @club = clubs(:valid_club)
    @second_user = users(:another_user)
  end

  test "can create an club" do
    login_as @user
    get "/clubs/new"
    assert_response :success
    assert_difference "Membership.count", 1 do
      post "/clubs", params: { club: { name: "Club Created"} }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "Club Created"
  end

  test "should show club index on landing page if user has created a club" do
    login_as @user
    assert_difference "Membership.count", 1 do
      @club.memberships.create(user: @user)
    end
    get root_url
    assert_redirected_to clubs_path
    follow_redirect!
    assert_response :success
    assert_select "h1", text: "Your Clubs"
    assert_select "div.card", text: @club.name
  end

  test "should show standard landing page on root if user has not created a club" do
    login_as @second_user
    assert_predicate @second_user.clubs, :empty?
    get root_url
    assert_select "h1", text: "Create a TV and book club with your  friends and get in sync!"
    assert_select "a", text: "Create a club!"
  end
end
