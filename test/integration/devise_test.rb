require 'test_helper'

class DeviseTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid_user)
  end

  test 'sign up and login pages can be accessed and form fields are present' do
    get new_user_registration_path
    assert_response :success
    assert_select "form[action='#{user_registration_path}']" do
      assert_select "input[name='user[email]']"
      assert_select "input[name='user[password]']"
      assert_select "input[name='user[password_confirmation]']"
    end

    get new_user_session_path
    assert_response :success
    assert_select "form[action='#{user_session_path}']" do
      assert_select "input[name='user[email]']"
      assert_select "input[name='user[password]']"
    end
  end

  test 'user can sign up and is redirected after sign up' do
    # Sign up
    post user_registration_path, params: {
      user: {
        email: 'new_user@example.com',
        first_name: 'First Name',
        last_name: 'Last Name',
        username: 'username',
        password: 'password',
        password_confirmation: 'password'
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
  end

  test 'user session is persisted between requests' do
    login_as @user
    get root_path
    assert_response :success
  end

  test 'user can log out and session is terminated' do
    login_as @user
    delete destroy_user_session_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 'Signed out successfully.', flash[:notice]
  end

  test 'correct error messages are displayed for invalid form data' do
    # Invalid sign up
    post user_registration_path, params: {
      user: {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }
    }
    assert_select '.alert', 'Please review the problems below:'

    # Invalid login
    post user_session_path, params: {
      user: {
        email: 'invalid@example.com',
        password: 'incorrect'
      }
    }
    assert_select '.alert', 'Invalid Email or password.'
  end
end
