require "test_helper"

class ClubTest < ActiveSupport::TestCase
  def setup
    @club = clubs(:valid_club)
  end

  test 'club.user returns only user who created club' do
    assert_not_nil @club.user
    assert_equal(@club.user, users(:valid_user))
    assert_not_equal(@club.user, users(:second_user))
  end

end
