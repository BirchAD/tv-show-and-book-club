require 'test_helper'

class DeleteClubTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
    @second_user = users(:another_user)
    @club = clubs(:valid_club)
  end

  test 'should not destroy club if user is not a member' do
    login_as @second_user
    assert_difference('Club.count', 0) do
      delete club_path(@club)
    end
    assert_redirected_to root_path
    assert_equal 'You are not a member of this club.', flash[:alert]
  end

  test 'should destroy club and membership' do
    login_as @user
    new_club = Club.create(name: "test", user: @user)
    assert_difference('Club.count', -1) do
      assert_difference('Membership.count', -1) do
        delete club_path(new_club)
      end
    end
    assert_redirected_to clubs_path
    assert_equal 'Club was successfully deleted.', flash[:notice]
    get clubs_path
    assert_response :success
    assert_select "div.card", text: @club.name, count: 0
  end
end
