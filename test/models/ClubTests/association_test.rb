require "test_helper"

describe Club do
  describe "Associations" do
    let(:club) { clubs(:valid_club) }

    it "has many memberships" do
      _(club.memberships).must_be_kind_of ActiveRecord::Associations::CollectionProxy
    end

    it "has many users through memberships" do
      _(club.users).must_be_kind_of ActiveRecord::Associations::CollectionProxy
    end
  end
end
