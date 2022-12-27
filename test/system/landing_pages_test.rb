require "application_system_test_case"

class LandingPagesTest < ApplicationSystemTestCase

  def setup
    @user = users(:valid_user)
    @user.save
  end

  test "Sign up and login should appear the index when not logged in" do
    visit root_url
    assert_selector "h1", text: "Create a TV and book club with your friends"
    assert_selector "a", text: "Sign Up"
    assert_selector "a", text: "Login"
  end

  test "User can login and sign up / login buttons won't be visible" do
    user_login
    assert_selector "a", text: "Messages"
    assert_selector "a", text: "Home"
    assert_no_selector "a", text: "Login"
    assert_no_selector "a", text: "Sign Up"
  end

  def user_login
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'password'
    click_button "Log In"
  end
end
