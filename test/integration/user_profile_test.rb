require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
  end

  test 'user can view profile page' do
    login_as @user
    get profile_path(@user)
    assert_response :success
    assert_template 'users/show'
    assert_select 'h1', @user.username
  end

  test "custom profile route is working" do
    assert_routing '/profile', { controller: 'users', action: 'show' }
  end
  Rails.application.routes.recognize_path '/profile', method: :get
end
