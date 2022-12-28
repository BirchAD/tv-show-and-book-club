require "application_system_test_case"

class ClubsTest < ApplicationSystemTestCase
  def setup
    @user = users(:valid_user)
  end

  test "lets a signed in access create a new club" do
    login_as @user
    visit root_url
    click_link "Create a club!"
    assert_current_path new_club_path
    fill_in "Name", with: "The Crew"
    click_on "Start Your Club"
    assert_text "The Crew"
  end

  test 'a user not logged in should not be able to access create a new club' do
    visit new_club_path
    assert_no_current_path new_club_path
    assert_current_path new_user_session_path
  end
end
