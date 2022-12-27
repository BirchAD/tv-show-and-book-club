require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
    @same_username = users(:same_username)
  end

  test 'username user test should be valid' do
    assert @user.valid?
  end

  test 'invalid without username' do
    @user.username = ""
    assert_not @user.valid?, 'Username valid is username is empty'
    assert_not_nil @user.errors[:username], 'no validation error for username present'
  end

  test "username should not exceed 10 characters" do
    @user.username = "p" * 15
    assert_not @user.valid?, 'Username valid if it exceeds 10 characters'
    assert_not_nil @user.errors[:username], 'no validation error for username exceeding 10 chars'
  end

  test "username should not be less than 3 characters" do
    @user.username = "pp"
    assert_not @user.valid?, 'Username valid if it is less than 3 characters'
    assert_not_nil @user.errors[:username], 'no validation error for username less than 3 chars'
  end

  test 'username must be unique string' do
    @same_username.username = @user.username
    assert_not @same_username.valid?, 'Username valid if not unique string'
    assert_not_nil @same_username[:username], 'no validation for unique username'
  end

  test 'username must be unique based on case sensitivity' do
    @same_username.username = "johnd"
    assert_not @same_username.valid?, 'Username valid if not case insensitive'
    assert_not_nil @same_username[:username], 'no validation for unique username based on case sens'
  end
end
