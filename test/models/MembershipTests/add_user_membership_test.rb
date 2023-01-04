require 'test_helper'

describe Club do
  describe "Add member to a club" do
    before do
      @user = users(:valid_user)
      @club = Club.new(name: "Teh Club", user: @user)
    end

    it "creates a membership for the owner" do
      _{ @club.save }.must_change "Membership.count", 1
      _(@club.memberships.count).must_equal 1
      _(@club.memberships.first.user).must_equal users(:valid_user)
    end

    it "lists memberships of a club" do
      @club.save
      _(@club.memberships.count).must_equal 1
    end

    it "lists users of a club" do
      @club.save
      _(@club.users.count).must_equal 1
    end
  end
end
