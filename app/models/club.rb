class Club < ApplicationRecord
  belongs_to :user
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, presence: true, length: { in: 3..15 }
  after_create :add_owner_memberships

  private

  def add_owner_memberships
    Membership.create(user: user, club: self)
  end
end
