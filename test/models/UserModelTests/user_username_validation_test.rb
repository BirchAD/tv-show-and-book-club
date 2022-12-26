require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:valid_user)
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'invalid without username' do
    @user.username = ""
    refute @user.valid?, 'Username valid is username is empty'
    assert_not_nil @user.errors[:username], 'no validation error for username present'
  end

  test "username should not exceed 10 characters" do
    @user.username = "p" * 15
    refute @user.valid?, 'Username valid if it exceeds 10 characters'
    assert_not_equal @user.errors[:username], 'no validation error for username exceeding 10 chars'
  end

  test "username should not be less than 3 characters" do
    @user.username = "pp"
    refute @user.valid?, 'Username valid if it is less than 3 characters'
    assert_not_equal @user.errors[:username], 'no validation error for username less than 3 chars'
  end
end
