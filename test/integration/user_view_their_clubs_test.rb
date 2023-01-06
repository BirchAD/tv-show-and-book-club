require 'test_helper'

class UserViewTheirClubsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:another_user)
    @club = clubs(:valid_club)
    @new_user = users(:another_user)
  end

  test 'user not logged redirected to login if attempting to view clubs' do
    get clubs_path
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_response :success
  end

  test 'logged in user can view clubs they are a member of' do
    login_as @user
    get clubs_path
    assert_response :success
    assert_select 'h1', text: 'Your Clubs'
    @user.clubs.each do |club|
      assert_select 'div.card', text: club.name
    end
    # Check that other clubs are not displayed on the page
    Club.all.each do |club|
      next if @user.clubs.include?(club)

      assert_select 'div.card', text: club.name, count: 0
    end
  end
end
