require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "full_name returns the capitalized first name and last name" do
    user = User.new(first_name: "john", last_name: "lennon")
    assert_equal "John Lennon", user.full_name
  end

  test "initials returns capitalize initials of first name and last name" do
    user = User.new(first_name: "jane", last_name: "doe")
    assert_equal "JD", user.initials
  end

  test "initials returns capitalized initials if user has multiple first names" do
    user = User.new(first_name: "james john", last_name: "bond")
    assert_equal "JJB", user.initials
  end

  test "initials returns capitalized initials if user has multiple last names" do
    user = User.new(first_name: "John", last_name: "Doe Brown" )
    assert_equal "JDB", user.initials
  end

  test "initials returns capitalized initials if user has - in first name" do
    user = User.new(first_name: "John-James", last_name: "Doe")
    assert_equal "JJD", user.initials
  end

  test "initials returns capitalized initials if user has - in last name" do
    user = User.new(first_name: "John", last_name: "Doe-Dylan")
    assert_equal "JDD", user.initials
  end
end
