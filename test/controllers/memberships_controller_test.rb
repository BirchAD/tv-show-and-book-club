require "test_helper"

class MembershipsControllerTest < ActionController::TestCase
  def setup
    @user = users(:valid_user)
    @club = clubs(:valid_club)
  end

  test "creates a new membership" do
    login_as @user
    assert_difference "Membership.count", 1 do
      post :create, params: { club_id: @club.id, membership: { user_id: @user.id } }
    end
    must_redirect_to club_path(@club)
  end

  test "does not create a duplicate membership" do
    Membership.create(user_id: @user.id, club_id: @club.id)
    login_as @user
    assert_no_difference "Membership.count" do
      post :create, params: { club_id: @club.id, membership: { user_id: @user.id } }
    end
  end
end
