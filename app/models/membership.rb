class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :club
  validates_uniqueness_of :user_id, scope: :club_id, message: "is already a member of this club"
end
