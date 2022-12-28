require 'test_helper'

class UserCreateClubTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:valid_user)
  end

  test "can create an club" do
    login_as @user
    get "/clubs/new"
    assert_response :success
    post "/clubs", params: { club: { name: "Club Created"} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "Club Created"
  end
end
