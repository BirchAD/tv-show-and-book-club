require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:valid_user)
  end

  test 'last name user test should be valid' do
    assert @user.valid?
  end

  test 'invalid without last_name' do
    @user.last_name = ""
    assert_not @user.valid?, 'last_name valid is last_name is empty'
    assert_not_nil @user.errors[:last_name], 'no validation error for last_name present'
  end

  test 'invalid if last name contains numbers' do
    @user.last_name = '1'
    assert_not @user.valid?, 'last name valid if contains numbers'
    assert_not_nil @user.errors[:last_name], 'no validation error for last name contains numbers'
  end

  test 'invalid if last name contains symbols' do
    @user.last_name = '*'
    assert_not @user.valid?, 'last name valid if contains symbols'
    assert_not_nil @user.errors[:last_name], 'no validation error for last name contains numbers'
  end

  test 'valid if only one space after a letter in last names' do
    @user.last_name = "John Jane"
    assert @user.valid?, 'last name valid if contains one space after a letter'
    assert_not_nil @user.errors[:last_name], 'no validation error if one space after a letter'
  end

  test 'invalid if more than one space after a letter in last names' do
    @user.last_name = "Jane  John"
    assert_not @user.valid?, 'last name valid if a last name has more than one space after a letter'
    assert_not_nil @user.errors[:last_name], 'no validation error if more than one space after a letter'
  end

  test 'invalid if last name over 25 characters' do
    @user.last_name = 'a' * 26
    assert_not @user.valid?, 'last name valid if over 25 characters'
    assert_not_nil @user.errors[:last_name], 'no validation errors if last name over 25 characters'
  end
end
