require 'application_system_test_case'

class ClubTests < ApplicationSystemTestCase
  def setup
    @user = users(:valid_user)
  end

  test 'lets a signed in access create a new club' do
    login_as @user
    visit root_url
    click_link 'Create a club!'
    assert_current_path new_club_path
    fill_in 'Name', with: 'The Crew'
    click_on 'Start Your Club'
    assert_selector 'h1', text: 'The Crew'
    click_link 'Your Clubs'
    assert_current_path clubs_path
    click_link 'The Crew'
    assert_current_path club_path(Club.last)
    assert_selector 'h2', text: 'Club Members'
    assert_selector 'li', text: @user.username.to_s
  end

  test 'a user not logged in should not be able to access create a new club' do
    visit new_club_path
    assert_no_current_path new_club_path
    assert_current_path new_user_session_path
  end
end
