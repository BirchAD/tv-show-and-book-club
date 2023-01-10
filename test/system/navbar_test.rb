require "application_system_test_case"

class NavbarTest < ApplicationSystemTestCase
  def setup
    @user = users(:valid_user)
  end

  test 'logged in user can see your clubs, add club and home buttons in navbar and button routes to clubs index' do
    login_as @user
    visit root_path
    assert_selector "nav li a", text: "Your Clubs"
    assert_selector "nav li a", text: "Add Club"
    click_on "Your Clubs"
    assert_current_path clubs_path
    click_on "Add Club"
    assert_current_path new_club_path
    click_on "Home"
    assert_current_path new_club_path
  end

  test 'non-logged in user can only see login button in navbar' do
    logout(@user)
    visit root_path
    assert_selector 'nav li a', text: 'Your Clubs', count: 0
    assert_selector 'nav li a', text: 'Login', count: 1
    click_on "Login"
    assert_current_path new_user_session_path
  end

  test 'logged in user can visit my profile from user avatar' do
    login_as @user
    visit root_path
    avatar = find("nav li img.avatar")
    avatar.click
    click_on "Profile"
    assert_current_path profile_path(@user)
    assert_selector "h1", text: @user.username
  end
end
