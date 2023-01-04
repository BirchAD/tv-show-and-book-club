require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:valid_user)
  end

  test 'first name user test should be valid' do
    assert @user.valid?
  end

  test 'invalid without first_name' do
    @user.first_name = ""
    assert_not @user.valid?, 'first_name valid is first_name is empty'
    assert_not_nil @user.errors[:first_name], 'no validation error for first_name present'
  end

  test 'invalid if first name contains numbers' do
    @user.first_name = '1'
    assert_not @user.valid?, 'first name valid if contains numbers'
    assert_not_nil @user.errors[:first_name], 'no validation error for first name contains numbers'
  end

  test 'invalid if first name contains symbols' do
    @user.first_name = '*'
    assert_not @user.valid?, 'first name valid if contains symbols'
    assert_not_nil @user.errors[:first_name], 'no validation error for first name contains numbers'
  end

  test 'valid if only one space after a letter in first names' do
    @user.first_name = "John Jane"
    assert @user.valid?, 'first name valid if contains one space after a letter'
    assert_not_nil @user.errors[:first_name], 'no validation error if one space after a letter'
  end

  test 'invalid if more than one space after a letter in first names' do
    @user.first_name = "Jane  John"
    assert_not @user.valid?, 'first name valid if a first name has more than one space after a letter'
    assert_not_nil @user.errors[:first_name], 'no validation error if more than one space after a letter'
  end

  test 'invalid if first name over 25 characters' do
    @user.first_name = 'a' * 26
    assert_not @user.valid?, 'first name valid if over 25 characters'
    assert_not_nil @user.errors[:first_name], 'no validation errors if first name over 25 characters'
  end
end
