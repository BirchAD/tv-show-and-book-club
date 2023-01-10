require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
    @second_user = users(:another_user)
  end

  test 'user can view profile page' do
    login_as @user
    get profile_path
    assert_response :success
    assert_template 'users/show'
    assert_select 'h1', @user.username
  end

  test 'custom profile route is working' do
    assert_routing '/profile', { controller: 'users', action: 'show' }
  end
  Rails.application.routes.recognize_path '/profile', method: :get

  test 'not logged in user is redirected to login page when attempting to view a profile' do
    get profile_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'user cannot view the profile of another user' do
    login_as @user
    get profile_path(@second_user)
    assert_response :redirect
    assert_redirected_to profile_path
    assert_equal flash[:alert], "You can only view your profile"
  end
end
