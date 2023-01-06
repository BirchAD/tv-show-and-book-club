require "application_system_test_case"

class AddMembershipToClubsTest < ApplicationSystemTestCase
  def setup
    @user = users(:valid_user)
    @second_user = users(:another_user)
    @club = clubs(:valid_club)
  end

  test 'logged in user can add a membership to a club' do
    login_as @user
    visit club_path(@club)
    click_link 'Add a friend to your club'
    fill_in "User", with: @second_user.email.to_s
    click_button 'Add To Your Club'
    assert_current_path club_path(@club)
    assert_text "#{@second_user.username} was added to the club"
    assert_selector 'h2', text: 'Club Members'
    assert_selector 'li', text: @second_user.username.to_s
    membership = Membership.last
    assert_equal @second_user, membership.user
    assert_equal @club, membership.club
  end
end
