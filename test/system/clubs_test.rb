require "application_system_test_case"

class ClubsTest < ApplicationSystemTestCase

  def setup
    @user = users(:valid_user)
  end

  test "lets a signed in user create a new club" do
    login_as @user
    visit root_url
    click_link "Create a club!"
    assert_current_path new_club_path
    fill_in "Name", with: "The Crew"
    # save_screenshot
    click_on "Create Club"
    # save_screenshot
    assert_text "The Crew"
  end
end
