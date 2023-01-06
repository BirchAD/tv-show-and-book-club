require "application_system_test_case"

class AddMembershipToClubsTest < ApplicationSystemTestCase
  def setup
    @user = users(:valid_user)
    @second_user = users(:another_user)
    @club = clubs(:valid_club)
  end

  test 'logged in user can add a membership to a club' do
    # Log in as the first user
    login_as @user

    # Visit the club's page
    visit club_path(@club)

    # Click the link to add a new membership
    # save_screenshot

    click_link 'Add a friend to your club'
    # Fill in the form with the second user's email
    fill_in "User", with: @second_user.email.to_s

    # Submit the form
    click_button 'Add To Your Club'

    # Verify that the membership was added and the user is redirected back to the club's page
    assert_current_path club_path(@club)
    assert_text "#{@second_user.username} was added to the club"
    assert_selector 'h2', text: 'Club Members'
    assert_selector 'li', text: @second_user.username.to_s

    # Verify that the membership was added to the database
    membership = Membership.last
    assert_equal @second_user, membership.user
    assert_equal @club, membership.club
  end
end
