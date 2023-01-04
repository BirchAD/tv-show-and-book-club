require "test_helper"

class ClubTest < ActiveSupport::TestCase
  def setup
    @club = clubs(:valid_club)
  end

  test 'club should be valid' do
    assert @club.valid?
  end

  test 'club should not be valid without a name' do
    @club.name = ""
    assert_not @club.valid?, 'club should not be valid without a name'
    assert_not_nil @club.errors[:name], 'no validation error for name present'
  end

  test 'club name should contain more than 3 characters' do
    @club.name = "aa"
    assert_not @club.valid?, 'club not valid if name less than 3 characters'
    assert_not_nil @club.errors[:name], 'no validation error for name less than 3 chars'
  end

  test 'club name should not contain more than 15 characters' do
    @club.name = "a" * 16
    assert_not @club.valid?, 'club not valid if name more than 15 characters'
    assert_not_nil @club.errors[:name], 'no validation error for name more than 15 chars'
  end
end
